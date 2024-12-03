# Documentação da Implementação de CI/CD

## Visão Geral

Esta documentação descreve a implementação de um processo de **CI/CD** para gerenciar a publicação de um sistema simples composto por uma página estática (`index.html`) e a atualização de um banco de dados (`Supabase PostgreSQL`). O objetivo é automatizar as atualizações do sistema e do banco de dados, garantindo que as versões mais recentes estejam sempre disponíveis em produção e testes, com controle de migrações de banco de dados.

Este processo utiliza as ferramentas **GitHub Actions**, **Azure Static Web Apps** e **Supabase PostgreSQL**. O workflow de CI/CD foi configurado para rodar de maneira automatizada com base em eventos nas branches `main` e `develop`.

---

## Estrutura do Repositório

O repositório do GitHub é composto por:

- **Branch `main`**: Contém a versão de produção do sistema, com um fluxo agendado de atualizações diárias do sistema e banco de dados.
- **Branch `develop`**: Contém a versão em desenvolvimento do sistema, onde qualquer PR resulta em atualizações do sistema e banco de dados.
- **Arquivos de Migração SQL**: Localizados em `supabase/migrations/`, responsáveis por definir as alterações no banco de dados.
- **Pipeline de CI/CD**: Configurada para as branches `main` e `develop`, usando **GitHub Actions** para automatizar o build, deploy e migração de banco de dados.

---

## Definição do Workflow de CI/CD

A pipeline foi projetada para atender aos seguintes requisitos:

### 1. **Branch `develop`**

Sempre que um Pull Request (PR) for feito para a branch `develop`, o processo de CI/CD deve ser acionado, realizando as seguintes tarefas:

- **Build e Deploy do Sistema**: O código da página `index.html` será enviado para o ambiente de hospedagem (Azure Static Web Apps).
- **Atualização do Banco de Dados**: O banco de dados do ambiente `develop` será atualizado com base nas migrações contidas no repositório.

### 2. **Branch `main`**

A branch `main` tem uma configuração especial, onde o sistema e o banco de dados serão atualizados de forma agendada todos os dias às 21:00 UTC.

- **Agendamento Diário**: A atualização será feita automaticamente pela GitHub Actions, sem a necessidade de PRs.
- **Build e Deploy do Sistema**: O código da página `index.html` será publicado.
- **Atualização do Banco de Dados**: As migrações de banco de dados serão aplicadas automaticamente.

### 3. **Mecanismo de Migração do Banco de Dados**

A migração do banco de dados é crucial, já que as versões do banco podem variar entre os ambientes `develop` e `main`. Cada vez que uma migração for realizada, ela será registrada para garantir que as migrações anteriores não sejam executadas novamente.

A tabela `migrations` foi criada para controlar o status das migrações. Ela inclui:

- `migration_name`: O nome do arquivo SQL da migração.
- `applied_at`: Data e hora da execução da migração.
- `status`: Status da migração (exemplo: "pending", "applied").
- `checksum`: Um hash do conteúdo SQL para verificar a integridade da migração.

---

## GitHub Actions: Workflow e Gatilhos

O workflow foi configurado com o arquivo `.github/workflows/ci-cd.yml`. Abaixo está uma explicação detalhada das seções do arquivo.

### Gatilhos

O workflow é acionado por três tipos de eventos:

1. **Push para a Branch `develop`**: Sempre que houver um push ou PR para a branch `develop`, a pipeline de deploy e migração será executada.
2. **Push para a Branch `main`**: O workflow também pode ser acionado por push, mas a principal atualização ocorrerá de forma agendada.
3. **Agendamento**: O workflow é executado diariamente às 21:00 UTC para a branch `main`.

```yaml
name: Azure Static Web Apps CI/CD

on:
  pull_request:
    types: [opened, synchronize, reopened, closed]
    branches:
      - develop
  push:
    branches:
      - main
    paths:
      - "supabase/migrations/main/*.sql"  # Monitora alterações nos arquivos .sql na branch main
  schedule:
    - cron: '0 21 * * *'  # Agendado para rodar todos os dias às 21:00 (UTC)


Develop: https://nice-bush-0dc6e431e.4.azurestaticapps.net/
Main: https://red-wave-06b407d1e.4.azurestaticapps.net/