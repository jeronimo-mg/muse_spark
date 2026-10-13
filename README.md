# Muse Spark Vibe Coding (OpenCode Free Tier)

Ambiente configurado para **vibe coding** nativo no Windows utilizando o modelo **Meta Muse Spark** (`opencode/muse-spark-1.3-contributor-free`) através do **OpenCode CLI**, totalmente sem custos de API.

---

## 🚀 Como Iniciar uma Sessão de Vibe Coding

Você pode iniciar o agente de desenvolvimento de três formas práticas:

### Opção 1: Via Launcher Rápido (Recomendado)
No terminal (CMD ou PowerShell) na raiz do projeto:
```cmd
bin\vibe.cmd
```
Ou no PowerShell:
```powershell
.\bin\vibe.cmd
```

### Opção 2: Via Script PowerShell com Parâmetros
O script `scripts/start-vibe.ps1` permite customizar a sessão:
```powershell
# Sessão padrão com Muse Spark
powershell.exe -ExecutionPolicy Bypass -File .\scripts\start-vibe.ps1

# Sessão com auto-aprovação de comandos (--auto)
powershell.exe -ExecutionPolicy Bypass -File .\scripts\start-vibe.ps1 -Auto

# Sessão com interface minimalista (--mini)
powershell.exe -ExecutionPolicy Bypass -File .\scripts\start-vibe.ps1 -Mini

# Execução direta com prompt inicial
powershell.exe -ExecutionPolicy Bypass -File .\scripts\start-vibe.ps1 -Prompt "Crie uma API REST em Node.js com Express"
```

### Opção 3: Diretamente pelo OpenCode CLI
Como o arquivo `opencode.json` na raiz do projeto já define o modelo `opencode/muse-spark-1.3-contributor-free`, basta rodar:
```bash
opencode
```

> **Dica Visual (Web UI):** Se preferir interagir via navegador, você pode iniciar o servidor web do OpenCode executando:
> ```bash
> opencode web
> ```

---

## 🛠️ Comandos Úteis do OpenCode durante a Sessão

Dentro da sessão interativa do OpenCode:
- `/help` — Exibe todos os comandos disponíveis no TUI.
- `/connect` — Gerencia e visualiza provedores e credenciais conectados.
- `/compact` — Compacta o histórico da sessão para liberar contexto.
- `/undo` — Desfaz as últimas alterações de código realizadas pelo agente.
- `Ctrl + C` — Interrompe a geração ou encerra a sessão.

---

## 🧪 Testes e Diagnóstico do Ambiente

Para verificar se todos os componentes e ferramentas continuam operacionais:

1. **Testes de Sanidade do Ambiente:**
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File .\tests\test-environment.ps1
   ```

2. **Diagnóstico Completo de Pré-requisitos:**
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File .\scripts\check-prerequisites.ps1
   ```

---

## 📁 Estrutura do Projeto

```
muse_spark/
├── bin/
│   └── vibe.cmd                # Launcher rápido em batch para Windows
├── conductor/                  # Especificações e governança Conductor
│   ├── product.md              # Visão e conceito do produto
│   ├── tech-stack.md           # Stack tecnológica e decisões arquiteturais
│   ├── workflow.md             # Fluxo de trabalho e qualidade
│   ├── tracks.md               # Registro de trilhas de desenvolvimento
│   └── tracks/initial_setup_*/ # Trilha inicial de instalação e configuração
├── instructions/
│   └── muse-spark.md           # Diretrizes comportamentais e persona do agente
├── scripts/
│   ├── check-prerequisites.ps1 # Diagnóstico de sistema (Git, Node, WSL, etc.)
│   ├── install-opencode.ps1    # Instalador/atualizador do OpenCode CLI
│   └── start-vibe.ps1          # Inicializador de sessão vibe coding
├── tests/
│   ├── test-prerequisites.ps1  # Testes do script de diagnóstico
│   └── test-environment.ps1    # Testes automatizados de sanidade do ambiente
├── opencode.json               # Configuração padrão do OpenCode (Muse Spark Free)
└── README.md                   # Este guia de uso
```
