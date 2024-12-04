# CI/CD Pipeline para Deploy de Sistema e Banco de Dados

Este repositório contém um exemplo de configuração de CI/CD para um sistema composto por uma página HTML estática (`index.html`) e um banco de dados PostgreSQL. O objetivo é automatizar o deploy do sistema e as atualizações do banco de dados para os branches `main` e `develop`, garantindo que as migrações sejam gerenciadas adequadamente.

## Estrutura do Projeto

O projeto contém os seguintes componentes principais:

- **HTML**: Uma página estática `index.html`, representando o sistema.
- **Banco de Dados**: PostgreSQL hospedado no Supabase, com suporte para migrações automatizadas.
- **Pipelines CI/CD**: Workflows configurados no GitHub Actions.

## Requisitos

- **GitHub Actions** para orquestrar o CI/CD.
- **Vercel** para hospedar as páginas HTML.
- **Supabase** para gerenciar os bancos de dados PostgreSQL.

## Configuração dos Branches

1. **Branch `develop`**:
   - Atualização automática do sistema e do banco de dados sempre que uma Pull Request (PR) for realizada.
   - Utiliza uma instância de banco de dados dedicada ao ambiente de desenvolvimento.

2. **Branch `main`**:
   - Atualização agendada do sistema e do banco de dados diariamente às 21:00.
   - Utiliza uma instância de banco de dados dedicada ao ambiente de produção.

3. Apenas `main` e `develop` aceitam merge via Pull Request.

## Estrutura da Pipeline

### 1. Configuração do Banco de Dados

Utilizamos o Supabase PostgreSQL para gerenciar os bancos de dados. As migrações são gerenciadas usando scripts SQL organizados na pasta `migrations/`. Um script de controle assegura que apenas migrações não aplicadas sejam executadas.

### 2. Hospedagem do Sistema

O arquivo `index.html` é hospedado usando a Vercel. Cada branch (`develop` e `main`) possui seu próprio site independente:

- **Ambiente de Desenvolvimento**: Hospeda o site gerado a partir de `develop`.
- **Ambiente de Produção**: Hospeda o site gerado a partir de `main`.

### 3. Workflows do GitHub Actions

#### Workflow para o Branch `develop`

- **Trigger**: Toda PR para o branch `develop`.
- **Ações**:
  - Executar migrações pendentes no banco de dados de desenvolvimento.
  - Fazer deploy do arquivo `index.html` no ambiente de desenvolvimento.

#### Workflow para o Branch `main`

- **Trigger**: Agendado diariamente às 21:00.
- **Ações**:
  - Executar migrações pendentes no banco de dados de produção.
  - Fazer deploy do arquivo `index.html` no ambiente de produção.

### Configuração dos Workflows

Os workflows estão definidos no diretório `.github/workflows/`:

- `develop-deploy.yml`: Define o pipeline para o branch `develop`.
- `main-deploy.yml`: Define o pipeline para o branch `main`.

## Como Configurar

1. **Banco de Dados**:
   - Crie duas instâncias no Supabase (uma para `develop` e outra para `main`).
   - Configure as URLs de conexão e credenciais no GitHub Actions Secrets.

2. **Hospedagem**:
   - Configure dois projetos na Vercel (um para cada branch).
   - Atualize as URLs no repositório, se necessário.

3. **Workflows**:
   - Insira as credenciais do banco e da Vercel nos Secrets do repositório no GitHub.
   - Ajuste os horários ou condições dos triggers, se necessário.

## Estrutura do Repositório

```
/
├── index.html             # Página HTML estática.
├── migrations/            # Diretório com scripts SQL de migração.
├── .github/workflows/     # Workflows do GitHub Actions.
│   ├── develop-deploy.yml # Pipeline para develop.
│   └── main-deploy.yml    # Pipeline para main.
├── README.md              # Documentação do projeto.
```

## Como Contribuir

1. Faça um fork do repositório.
2. Crie uma branch para sua feature ou correção: `git checkout -b minha-branch`.
3. Faça commit das suas alterações: `git commit -m 'Minha contribuição'`.
4. Abra uma Pull Request para o branch correspondente.

## Considerações Finais

Este repositório serve como exemplo para configurar pipelines CI/CD simples e eficientes. Caso tenha dúvidas ou sugestões, sinta-se à vontade para abrir uma *issue* no repositório.
