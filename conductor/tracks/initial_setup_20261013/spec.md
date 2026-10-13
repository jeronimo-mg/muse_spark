# Specification: Configuração do Ambiente e Instalação do Muse Spark / Muse Code para Vibe Coding

## Overview
Esta trilha estabelece a infraestrutura e os scripts necessários para instalar, configurar e validar o ambiente de desenvolvimento orientado a agentes usando o **Muse Spark** e a **Muse Code CLI** no Windows (com integração transparente ao WSL2).

## Objectives
1. Automatizar a verificação dos requisitos do sistema (WSL2, Git, runtimes Node/Python).
2. Criar scripts de instalação e provisionamento do `muse` CLI no subsistema Linux com ponte para execução no Windows.
3. Desenvolver comandos e atalhos de conveniência em PowerShell para inicialização rápida de sessões de "vibe coding".
4. Implementar testes automatizados de diagnóstico e health check para garantir que o ambiente está 100% operacional.

## Functional Requirements
- **FR-1: Diagnóstico de Pré-requisitos:** Script PowerShell (`scripts/check-prerequisites.ps1`) para checar status do WSL2, conectividade com a internet, presença de Git e configurações de virtualização.
- **FR-2: Script de Instalação:** Script automatizado (`scripts/install-muse.ps1` e `scripts/setup-wsl-muse.sh`) para instalar o CLI oficial do Muse dentro do WSL2.
- **FR-3: Script de Wrapper Windows:** Script `muse.cmd` ou função PowerShell para permitir executar `muse` diretamente a partir do terminal do Windows na pasta atual.
- **FR-4: Gerenciamento de Credenciais/Ambiente:** Guia interativo e script para configuração das variáveis de ambiente e autenticação da Meta.
- **FR-5: Suíte de Testes & Sanity Check:** Script de testes (`tests/test-environment.ps1`) que valida a instalação da CLI, versão e conectividade.

## Non-Functional Requirements
- **NFR-1:** Execução idempotente (pode ser executada múltiplas vezes sem quebrar o estado).
- **NFR-2:** Mensagens informativas claras em português, com indicação visual de sucesso/aviso/erro.
- **NFR-3:** Sem dependência de privilégios de administrador após o WSL estar ativo.

## Acceptance Criteria
- [ ] O script de pré-requisitos detecta e reporta com precisão o status do sistema.
- [ ] O Muse Code CLI é instalado e reporta versão funcional (`muse --version`).
- [ ] É possível invocar o comando do Muse a partir do PowerShell apontando para o diretório de trabalho atual.
- [ ] A suíte de verificação passa com sucesso.
