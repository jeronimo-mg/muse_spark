<#
.SYNOPSIS
    Inicializador de sessão de Vibe Coding com Meta Muse Spark via OpenCode CLI.
.DESCRIPTION
    Inicia o OpenCode CLI configurado por padrão com o modelo gratuito Meta Muse Spark 1.3
    (opencode/muse-spark-1.3-contributor-free), permitindo vibe coding ágil e sem custos.
.PARAMETER Model
    Modelo a ser utilizado. Padrão: opencode/muse-spark-1.3-contributor-free
.PARAMETER Prompt
    Prompt inicial opcional para executar diretamente ou iniciar o diálogo.
.PARAMETER Auto
    Habilita auto-aprovação de permissões no OpenCode (--auto).
.PARAMETER Mini
    Utiliza a interface interativa minimalista (--mini).
.PARAMETER ContinueSession
    Continua a sessão anterior (--continue).
.PARAMETER Project
    Diretório de trabalho do projeto (padrão: diretório atual).
#>
[CmdletBinding()]
param(
    [string]$Model = "opencode/muse-spark-1.3-contributor-free",
    [string]$Prompt = "",
    [switch]$Auto,
    [switch]$Mini,
    [switch]$ContinueSession,
    [string]$Project = (Get-Location).Path
)

Write-Host "`n=======================================================" -ForegroundColor Cyan
Write-Host "   MUSE SPARK VIBE CODING (OpenCode Free Tier)         " -ForegroundColor Yellow
Write-Host "=======================================================`n" -ForegroundColor Cyan

# 1. Verificar disponibilidade do opencode
$opencodeCmd = Get-Command opencode -ErrorAction SilentlyContinue
if (-not $opencodeCmd) {
    # Tentar recarregar PATH do npm
    $userNpm = "$env:APPDATA\npm"
    if (Test-Path "$userNpm\opencode.cmd") {
        $opencodeCmd = "$userNpm\opencode.cmd"
    } else {
        Write-Host "[ERRO] OpenCode CLI não foi encontrado. Execute scripts/install-opencode.ps1 primeiro." -ForegroundColor Red
        exit 1
    }
}

Write-Host "Projeto : $Project" -ForegroundColor Gray
Write-Host "Modelo  : $Model" -ForegroundColor Green
if ($Auto) { Write-Host "Modo    : Auto-approve ativo (--auto)" -ForegroundColor Yellow }
if ($Mini) { Write-Host "UI      : Interface minimalista (--mini)" -ForegroundColor Gray }

# 2. Montar argumentos
$argList = @()
$argList += "-m"
$argList += $Model

if ($Auto) {
    $argList += "--auto"
}

if ($Mini) {
    $argList += "--mini"
}

if ($ContinueSession) {
    $argList += "--continue"
}

if ($Prompt) {
    $argList += "--prompt"
    $argList += $Prompt
}

# 3. Executar o OpenCode no diretório indicado
Push-Location $Project
try {
    Write-Host "`nConectando ao agente Muse Spark... Pressione Ctrl+C para encerrar.`n" -ForegroundColor Cyan
    & opencode @argList
} finally {
    Pop-Location
}
