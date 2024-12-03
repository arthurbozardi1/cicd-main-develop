# CI/CD with Supabase Integration

Este repositório utiliza uma pipeline de **CI/CD** para automatizar o processo de deploy do código e a aplicação de migrações de banco de dados no Supabase, usando GitHub Actions. A pipeline foi configurada para as branches `main` e `develop`, com diferentes comportamentos de deploy e migração.

## Fluxo de CI/CD

### Branches

- **main**: A pipeline é acionada quando há um push ou uma PR aberta/sincronizada/reaberta para a branch `main`. O deploy é realizado automaticamente, e migrações de banco de dados são aplicadas.
- **develop**: A pipeline é idêntica à da branch `main`, com as mesmas ações de deploy e migração, mas voltada para a branch `develop`. As únicas diferenças são as URLs e o caminho dos arquivos de migração.

### Ações da Pipeline

A pipeline possui três principais etapas:

1. **Checkout do código**: O código é obtido a partir do repositório, incluindo submódulos e desabilitando o LFS (Large File Storage).
2. **Aplicação das migrações do Supabase**: A conexão com o banco de dados do Supabase é feita usando uma string de conexão armazenada como segredo no GitHub (e diferente para `main` e `develop`). Se houver arquivos de migração disponíveis na pasta `supabase/migrations/main/`, eles serão aplicados ao banco de dados.
3. **Deploy do aplicativo estático**: O código é implantado em uma Azure Static Web App, utilizando um token de API do Azure e o repositório do GitHub.

### Detalhamento da Configuração

A seguir estão os detalhes sobre cada job da pipeline:

#### Job 1: `build_and_deploy_job`

Este job é responsável por:

- **Checkout do código**: Faz o checkout do código, incluindo submódulos.
- **Configuração de variáveis de ambiente**: Define a string de conexão com o banco de dados a partir dos segredos armazenados no GitHub (`SUPABASE_DB_URL_MAIN` para `main` e `SUPABASE_DB_URL_DEVELOP` para `develop`).
- **Validação da string de conexão**: Garante que a string de conexão do banco de dados foi definida corretamente.
- **Aplicação de migrações**: Aplica migrações ao banco de dados usando os arquivos SQL localizados em `supabase/migrations/main/` para a branch `main`, e `supabase/migrations/develop/` para a branch `develop`.
- **Deploy**: Faz o upload do código para uma Azure Static Web App.

```yaml
name: Build, Deploy, and Update Supabase Database
```

### URLs:
- **Branch `main`**: [https://blue-mushroom-03989e210.4.azurestaticapps.net/](https://blue-mushroom-03989e210.4.azurestaticapps.net/)
- **Branch `develop`**: [https://orange-forest-09524c210.4.azurestaticapps.net/](https://orange-forest-09524c210.4.azurestaticapps.net/)
