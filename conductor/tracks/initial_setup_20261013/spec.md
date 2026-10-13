# Specification: Configuração do Ambiente OpenCode com Muse Spark (Sem Custos)

## Overview
Esta trilha estabelece o ambiente e os scripts necessários para instalar e configurar o **OpenCode CLI** com o modelo **Meta Muse Spark** (fornecido sem custos pela plataforma OpenCode) para sessões fluidas de vibe coding no Windows.

## Objectives
1. Validar os pré-requisitos do sistema Windows (Node.js, Git, PowerShell).
2. Automatizar a instalação global do OpenCode CLI (`opencode-ai`).
3. Fornecer guia e scripts de conexão ao modelo Muse Spark 1.3 gratuito.
4. Criar utilitário PowerShell (`scripts/start-vibe.ps1`) para lançar sessões de vibe coding no diretório de trabalho.
5. Desenvolver testes automatizados de sanidade do ambiente.

## Functional Requirements
- **FR-1: Diagnóstico de Pré-requisitos:** Validar Node.js >= 20, npm, Git e conectividade com o registro npm / OpenCode.
- **FR-2: Instalação Automatizada:** Script PowerShell (`scripts/install-opencode.ps1`) que instala ou atualiza o `opencode-ai`.
- **FR-3: Script de Inicialização da Sessão:** Script (`scripts/start-vibe.ps1`) e comando wrapper (`bin/vibe.cmd`) para inicializar o OpenCode com Muse Spark diretamente no projeto.
- **FR-4: Configuração de Modelo:** Documentação e automação de configuração inicial do modelo Muse Spark (via `/connect` ou arquivo de configuração do OpenCode).
- **FR-5: Suíte de Validação:** Testes automatizados (`tests/test-environment.ps1`) validando a integridade da instalação do CLI e comandos.

## Acceptance Criteria
- [ ] O script de pré-requisitos confirma os componentes essenciais (Node.js, npm, Git).
- [ ] O OpenCode CLI está instalado e responde no terminal (`opencode --version`).
- [ ] Os scripts de inicialização de vibe coding estão prontos e documentados.
- [ ] A suíte de testes passa com 100% de sucesso.
