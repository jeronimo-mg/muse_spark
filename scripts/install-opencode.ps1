<#
.SYNOPSIS
    Instalação e verificação do OpenCode CLI nativo no Windows.
.DESCRIPTION
    Instala globalmente o pacote opencode-ai usando npm.cmd e valida a execução do comando opencode.
.PARAMETER CheckOnly
    Apenas verifica se o OpenCode CLI está instalado e funcional, sem tentar instalar.
.PARAMETER Force
    Força a reinstalação mesmo que já esteja presente.
#>
[CmdletBinding()]
param(
    [switch]$CheckOnly,
    [switch]$Force
)

Write-Host "`n=== Muse Spark: Instalação do OpenCode CLI ===`n" -ForegroundColor Cyan

# 1. Verificar Node.js
$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeCmd) {
    Write-Host "[ERRO] Node.js não foi encontrado no PATH. Instale o Node.js v20+ antes de continuar." -ForegroundColor Red
    exit 1
}
$nodeVer = (node -v 2>&1).Trim()
Write-Host "Node.js detectado: $nodeVer" -ForegroundColor Green

# 2. Localizar comando npm
$npmExecutable = $null
if (Get-Command "npm.cmd" -ErrorAction SilentlyContinue) {
    $npmExecutable = "npm.cmd"
} elseif (Get-Command "npm" -ErrorAction SilentlyContinue) {
    $npmExecutable = "npm"
} else {
    Write-Host "[ERRO] npm não foi encontrado no PATH." -ForegroundColor Red
    exit 1
}

# 3. Verificar se opencode já está disponível
$existingOpencode = Get-Command opencode -ErrorAction SilentlyContinue
if ($existingOpencode -and (-not $Force)) {
    try {
        $ver = (& opencode --version 2>&1).Trim()
        Write-Host "[OK] OpenCode CLI já está instalado: $ver" -ForegroundColor Green
        if ($CheckOnly) { exit 0 }
        Write-Host "Use -Force para forçar a reinstalação ou atualização.`n" -ForegroundColor Gray
        exit 0
    } catch {
        Write-Host "[AVISO] Comando opencode encontrado, mas falhou ao responder. Prosseguindo com instalação..." -ForegroundColor Yellow
    }
}

if ($CheckOnly) {
    Write-Host "[INFO] OpenCode CLI ainda não está instalado." -ForegroundColor Yellow
    exit 1
}

# 4. Executar instalação global
Write-Host "Instalando o pacote 'opencode-ai' globalmente via npm..." -ForegroundColor Cyan
$installProc = Start-Process -FilePath $npmExecutable -ArgumentList "install", "-g", "opencode-ai" -NoNewWindow -Wait -PassThru

if ($installProc.ExitCode -ne 0) {
    Write-Host "[ERRO] Falha na instalação do opencode-ai via npm (Código de saída: $($installProc.ExitCode))." -ForegroundColor Red
    exit $installProc.ExitCode
}

# 5. Atualizar PATH na sessão atual caso necessário
$userNpmPath = "$env:APPDATA\npm"
if ((Test-Path $userNpmPath) -and ($env:PATH -notlike "*$userNpmPath*")) {
    $env:PATH = "$userNpmPath;$env:PATH"
}

# 6. Validar a instalação
$verifiedOpencode = Get-Command opencode -ErrorAction SilentlyContinue
if (-not $verifiedOpencode) {
    # Tentar procurar no diretório global do npm
    if (Test-Path "$userNpmPath\opencode.cmd") {
        $verifiedOpencode = "$userNpmPath\opencode.cmd"
    }
}

if ($verifiedOpencode) {
    try {
        $ver = (& opencode --version 2>&1).Trim()
        Write-Host "`n[SUCESSO] OpenCode CLI instalado com sucesso: $ver" -ForegroundColor Green
        Write-Host "Para iniciar, você pode executar: opencode`n" -ForegroundColor Cyan
        exit 0
    } catch {
        Write-Host "`n[AVISO] OpenCode CLI instalado, mas é recomendável reabrir o terminal para carregar o PATH." -ForegroundColor Yellow
        exit 0
    }
} else {
    Write-Host "`n[AVISO] Instalação concluída pelo npm. Se o comando 'opencode' não for reconhecido de imediato, reinicie o terminal.`n" -ForegroundColor Yellow
    exit 0
}
