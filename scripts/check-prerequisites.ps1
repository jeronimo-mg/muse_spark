<#
.SYNOPSIS
    Diagnóstico de pré-requisitos para o ambiente Muse Spark / Muse Code (Vibe Coding).
.DESCRIPTION
    Verifica a presença e o estado de componentes fundamentais:
    PowerShell, Git, Node.js, Python, WSL2 (com distro Linux) e conectividade.
.PARAMETER Json
    Retorna os resultados no formato JSON.
#>
[CmdletBinding()]
param(
    [switch]$Json
)

function Write-Step {
    param([string]$Status, [string]$Message, [string]$Details = "")
    switch ($Status) {
        "OK"   { Write-Host "  [OK]   " -ForegroundColor Green -NoNewline }
        "WARN" { Write-Host "  [WARN] " -ForegroundColor Yellow -NoNewline }
        "FAIL" { Write-Host "  [FAIL] " -ForegroundColor Red -NoNewline }
        "INFO" { Write-Host "  [INFO] " -ForegroundColor Cyan -NoNewline }
    }
    Write-Host $Message -NoNewline
    if ($Details) {
        Write-Host " ($Details)" -ForegroundColor Gray
    } else {
        Write-Host ""
    }
}

$results = [ordered]@{}
$hasFailures = $false

Write-Host "`n=== Muse Spark: Verificação de Pré-requisitos do Sistema ===`n" -ForegroundColor Cyan

# 1. PowerShell
$psVersion = $PSVersionTable.PSVersion.ToString()
$results["PowerShell"] = @{ Status = "OK"; Version = $psVersion }
Write-Step "OK" "PowerShell" "v$psVersion"

# 2. Git
$gitCmd = Get-Command git -ErrorAction SilentlyContinue
if ($gitCmd) {
    $gitVer = (git --version 2>&1).Trim()
    $results["Git"] = @{ Status = "OK"; Version = $gitVer }
    Write-Step "OK" "Git" $gitVer
} else {
    $results["Git"] = @{ Status = "FAIL"; Message = "Git não encontrado no PATH" }
    Write-Step "FAIL" "Git" "Não instalado ou ausente no PATH"
    $hasFailures = $true
}

# 3. Node.js
$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if ($nodeCmd) {
    $nodeVer = (node -v 2>&1).Trim()
    $results["NodeJS"] = @{ Status = "OK"; Version = $nodeVer }
    Write-Step "OK" "Node.js" $nodeVer
} else {
    $results["NodeJS"] = @{ Status = "WARN"; Message = "Node.js não encontrado no PATH" }
    Write-Step "WARN" "Node.js" "Não encontrado (recomendado para SDK e ferramentas)"
}

# 4. Python
$pyCmd = Get-Command python -ErrorAction SilentlyContinue
if ($pyCmd) {
    $pyVer = (python --version 2>&1).Trim()
    $results["Python"] = @{ Status = "OK"; Version = $pyVer }
    Write-Step "OK" "Python" $pyVer
} else {
    $results["Python"] = @{ Status = "WARN"; Message = "Python não encontrado no PATH" }
    Write-Step "WARN" "Python" "Opcional mas recomendado"
}

# 5. WSL2
$wslCmd = Get-Command wsl -ErrorAction SilentlyContinue
if ($wslCmd) {
    # Testar se há alguma distribuição instalada
    $wslList = (wsl -l -q 2>&1)
    $wslDistros = @()
    if ($LASTEXITCODE -eq 0 -and $wslList) {
        $wslDistros = $wslList | Where-Object { $_ -match "\S" } | ForEach-Object { $_.Trim().Replace("`0", "") }
    }
    
    if ($wslDistros.Count -gt 0) {
        $results["WSL"] = @{ Status = "OK"; Distros = ($wslDistros -join ", ") }
        Write-Step "OK" "WSL (Windows Subsystem for Linux)" "Distros: $($wslDistros -join ', ')"
    } else {
        $results["WSL"] = @{ Status = "WARN"; Message = "WSL disponível, mas nenhuma distribuição instalada" }
        Write-Step "WARN" "WSL" "Substantivo presente, mas sem distribuição Linux (instale com: wsl --install -d Ubuntu)"
    }
} else {
    $results["WSL"] = @{ Status = "FAIL"; Message = "Comando wsl não encontrado" }
    Write-Step "FAIL" "WSL" "Não encontrado. Ative o recurso WSL2 no Windows."
    $hasFailures = $true
}

# 6. Conectividade com a Internet
$netTest = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet -ErrorAction SilentlyContinue
if ($netTest) {
    $results["Internet"] = @{ Status = "OK" }
    Write-Step "OK" "Conectividade de Rede" "Acesso à internet OK"
} else {
    $results["Internet"] = @{ Status = "WARN"; Message = "Falha no ping" }
    Write-Step "WARN" "Conectividade de Rede" "Verifique a conexão"
}

Write-Host ""
if ($Json) {
    $results | ConvertTo-Json -Depth 3
}

if ($hasFailures) {
    Write-Host "Existem itens essenciais com falha. Por favor, revise as mensagens acima.`n" -ForegroundColor Red
    exit 1
} else {
    Write-Host "Verificação concluída. Ambiente pronto para provisionamento!`n" -ForegroundColor Green
    exit 0
}
