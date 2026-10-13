<#
.SYNOPSIS
    Testes automatizados para validação do script check-prerequisites.ps1.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$testScriptPath = Join-Path $PSScriptRoot "..\scripts\check-prerequisites.ps1"
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
            Write-Host "  [FAIL] $Name (Condição retornou falso)" -ForegroundColor Red
            $script:failedCount++
        }
    } catch {
        Write-Host "  [FAIL] $Name (Exceção: $_)" -ForegroundColor Red
        $script:failedCount++
    }
}

Write-Host "`n=== Executando Testes: check-prerequisites.ps1 ===`n" -ForegroundColor Cyan

# Teste 1: Existência do arquivo
Assert-Test "O arquivo check-prerequisites.ps1 existe" {
    Test-Path $testScriptPath
}

# Teste 2: Execução sem crash
Assert-Test "O script executa sem erros de sintaxe" {
    $output = & powershell.exe -ExecutionPolicy Bypass -File $testScriptPath 2>&1
    return ($output -ne $null -and $output.Count -gt 0)
}

# Teste 3: Suporte ao parâmetro -Json
Assert-Test "O script suporta o switch -Json e gera saída contendo JSON válido" {
    $rawOutput = & powershell.exe -ExecutionPolicy Bypass -File $testScriptPath -Json 2>&1
    # Extrair bloco JSON entre as primeiras '{' e última '}'
    $joined = $rawOutput -join "`n"
    $match = [regex]::Match($joined, '\{[\s\S]*\}')
    if (-not $match.Success) { return $false }
    $parsed = $match.Value | ConvertFrom-Json
    return ($parsed -ne $null)
}

# Teste 4: Campos obrigatórios no JSON
Assert-Test "O JSON gerado contém as chaves esperadas (PowerShell, Git, NodeJS, Python, WSL, Internet)" {
    $rawOutput = & powershell.exe -ExecutionPolicy Bypass -File $testScriptPath -Json 2>&1
    $joined = $rawOutput -join "`n"
    $match = [regex]::Match($joined, '\{[\s\S]*\}')
    $parsed = $match.Value | ConvertFrom-Json
    return (
        ($parsed.PowerShell -ne $null) -and
        ($parsed.Git -ne $null) -and
        ($parsed.NodeJS -ne $null) -and
        ($parsed.Python -ne $null) -and
        ($parsed.WSL -ne $null) -and
        ($parsed.Internet -ne $null)
    )
}

Write-Host "`nTotal: $passedCount passaram, $failedCount falharam.`n" -ForegroundColor $(if ($failedCount -eq 0) { "Green" } else { "Red" })

if ($failedCount -gt 0) {
    exit 1
} else {
    exit 0
}
