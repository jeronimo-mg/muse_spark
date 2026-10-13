# Technology Stack: Muse Spark Vibe Coding (via OpenCode)

## Architecture & Deviation Note
> **[2026-10-13] Decisão Arquitetural / Ajuste de Direcionamento:**
> Ajustado para utilizar o **OpenCode CLI** (`opencode-ai`) nativamente no Windows com o modelo **Meta Muse Spark** (`muse-spark-1.3`) fornecido sem custos (Free Contributor / Zero-Cost OpenCode tier). Isso elimina a dependência obrigatória do WSL2 para o dia a dia e permite execução nativa no PowerShell/Windows de forma rápida e gratuita.

## Core Environment & Runtimes
- **Host OS:** Windows 11 / Windows 10
- **Runtimes:**
  - Node.js (v24+ / LTS) - Nativo
  - npm.cmd / npx
  - Git 2.40+ (Windows)
- **Shell:** Windows PowerShell 5.1 / PowerShell 7+

## AI Agent & Model Stack
- **Primary Reasoning Model:** Meta Muse Spark (`muse-spark-1.3`)
- **Coding Agent CLI:** OpenCode CLI (`opencode-ai` via npm)
- **Model Provider/Tier:** OpenCode Free / Contributor tier (sem custos de API)

## Tooling & Automation
- **Automation Scripts:** Scripts PowerShell (`.ps1`) para verificação, instalação e inicialização (`scripts/`)
- **Sanity & Test Suites:** Testes de ambiente automatizados em PowerShell (`tests/`)
- **Editor / IDE:** VS Code / Cursor integrado ao terminal do projeto
