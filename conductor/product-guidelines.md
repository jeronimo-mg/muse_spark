# Product Guidelines: Muse Spark Vibe Coding

## Core Principles

1. **Seamless Vibe Experience:**
   - Reduzir atritos de configuração ao mínimo.
   - Scripts devem ser idempotentes, claros e com saídas amigáveis e coloridas.
   - Tratamento de erro detalhado com orientações acionáveis para o usuário.

2. **Segurança & Boas Práticas:**
   - Jamais expor ou salvar chaves de API / tokens em texto aberto no controle de versão.
   - Utilizar variáveis de ambiente (`.env.local` ignorado pelo Git).
   - Executar comandos privilegiados apenas quando estritamente necessário, com confirmação explícita.

3. **Arquitetura Híbrida Windows / WSL2:**
   - Como o Muse Code CLI nativo roda em ambientes POSIX/Linux, o ecossistema deve orquestrar transparentemente comandos entre o host Windows (PowerShell) e o WSL2.
   - Scripts de conveniência em PowerShell (`.ps1`) e Bash (`.sh`) para garantir flexibilidade máxima.

4. **Qualidade & Confiabilidade:**
   - Scripts com verificações automáticas de pré-requisitos antes da execução.
   - Testes automatizados de validação de ambiente e sanidade da CLI.
