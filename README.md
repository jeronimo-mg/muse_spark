# Muse Spark Vibe Coding (OpenCode Free Tier)

Ambiente configurado para **vibe coding** nativo no Windows utilizando o modelo **Meta Muse Spark** (`opencode/muse-spark-1.3-contributor-free`) através do **OpenCode CLI**, totalmente sem custos de API.

---

## 🚀 Como Iniciar uma Sessão de Vibe Coding

Graças à configuração global no sistema, você agora pode abrir **qualquer terminal (PowerShell ou Prompt de Comando)** em **qualquer pasta** do computador e rodar diretamente:

```bash
vibe
```
ou:
```bash
muse
```

O comando inicia automaticamente o agente com o **Meta Muse Spark** (`opencode/muse-spark-1.3-contributor-free`) e ativa a ponte local de proxy para contornar qualquer bloqueio corporativo.

### Exemplos de Uso Global (em qualquer pasta):

```bash
# Iniciar sessão interativa de vibe coding na pasta atual
vibe

# Iniciar diretamente com uma instrução
vibe "crie um servidor HTTP em Node.js com TypeScript"

# Iniciar com permissões automáticas (YOLO / auto-approve)
vibe --auto

# Iniciar interface visual no navegador
vibe web

# Listar os modelos disponíveis
vibe models opencode
```

> **Nota:** Se você preferir rodar `opencode` diretamente, ele também foi integrado à ponte de proxy automaticamente.

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
