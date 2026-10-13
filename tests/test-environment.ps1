<#
.SYNOPSIS
    Testes de validação do ambiente OpenCode + Muse Spark.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$failedCount = 0
$passedCount = 0

function Assert-Test {
    param(
        [string]$Name,
        [scriptblock]$Condition
    )
    try {
        $result = & $Condition
        if ($result) {
            Write-Host "  [PASS] $Name" -ForegroundColor Green
            $script:passedCount++
        } else {
            Write-Host "  [FAIL] $Name" -ForegroundColor Red
            $script:failedCount++
        }
    } catch {
        Write-Host "  [FAIL] $Name (Exceção: $_)" -ForegroundColor Red
        $script:failedCount++
    }
}

Write-Host "`n=== Testes de Sanidade: Ambiente OpenCode & Muse Spark ===`n" -ForegroundColor Cyan

# Teste 1: Executável do OpenCode
Assert-Test "OpenCode CLI está disponível no sistema" {
    $cmd = Get-Command opencode -ErrorAction SilentlyContinue
    if (-not $cmd) {
        $userNpm = "$env:APPDATA\npm\opencode.cmd"
        return (Test-Path $userNpm)
    }
    return $true
}

# Teste 2: Versão do OpenCode
Assert-Test "OpenCode responde ao comando --version com versão válida" {
    $ver = (& opencode --version 2>&1).Trim()
    return ($ver -match '^\d+\.\d+\.\d+')
}

# Teste 3: Disponibilidade do modelo Muse Spark (Free Contributor)
Assert-Test "Modelo 'opencode/muse-spark-1.3-contributor-free' está disponível no OpenCode" {
    $models = (& opencode models 2>&1)
    return ($models -match 'muse-spark-1.3-contributor-free')
}

# Teste 4: Arquivo opencode.json
Assert-Test "Arquivo opencode.json existe e define o modelo Muse Spark padrão" {
    $cfgPath = Join-Path $projectRoot "opencode.json"
    if (-not (Test-Path $cfgPath)) { return $false }
    $json = Get-Content $cfgPath -Raw | ConvertFrom-Json
    return ($json.model -eq "opencode/muse-spark-1.3-contributor-free")
}

# Teste 5: Arquivo instructions/muse-spark.md
Assert-Test "Arquivo instructions/muse-spark.md existe e contém diretrizes de vibe coding" {
    $instPath = Join-Path $projectRoot "instructions\muse-spark.md"
    if (-not (Test-Path $instPath)) { return $false }
    $content = Get-Content $instPath -Raw
    return ($content.Length -gt 50 -and $content -match "Muse Spark")
}

# Teste 6: Utilitários de inicialização (start-vibe.ps1 e vibe.cmd)
Assert-Test "Scripts de inicialização rápida (scripts/start-vibe.ps1 e bin/vibe.cmd) existem" {
    $ps1 = Join-Path $projectRoot "scripts\start-vibe.ps1"
    $cmd = Join-Path $projectRoot "bin\vibe.cmd"
    return ((Test-Path $ps1) -and (Test-Path $cmd))
}

Write-Host "`nTotal: $passedCount passaram, $failedCount falharam.`n" -ForegroundColor $(if ($failedCount -eq 0) { "Green" } else { "Red" })

if ($failedCount -gt 0) {
    exit 1
} else {
    exit 0
}
