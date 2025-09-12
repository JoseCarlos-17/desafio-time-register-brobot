# Desafio Time Register - API Ruby on Rails

## Descrição

Esta aplicação é um sistema de controle de ponto para usuários, permitindo o registro de horários de trabalho, intervalos e saídas. O projeto inclui API RESTful para gerenciamento de usuários e seus registros de horário (`TimeRegister`), além de uma tarefa Rake para popular dados de teste.

---

## Pré-requisitos

- Ruby 3.1.2
- Rails 7.1.5
- PostgreSQL
- Docker e Docker Compose
- Bundler

---

## Instalação e Setup

### 1. Clonar o repositório

```bash
git clone git@github.com:JoseCarlos-17/desafio-time-register-brobot.git
cd <NOME_DO_PROJETO>
```

### 2. Instalar dependências

```bash
bundle install
```

### 3. Configuração do banco de dados

#### Docker

```bash
docker compose up -d
```

#### Banco de dados Rails

```bash
rails db:create
rails db:migrate
```

### 4. Configuração de variáveis de ambiente

Crie um arquivo `.env` com as seguintes variáveis (exemplo):

```env
DB_USERNAME=
DB_PASSWORD=
DB_HOST=db
DB_PORT=5432
```

os valores de DB_USERNAME e DB_PASSWORD devem ser preenchidos com seu usuário do postgres.

> **Importante:** Nunca compartilhe o `.env` com credenciais sensíveis em repositórios públicos.

---

## Como Executar

### Desenvolvimento local

```bash
bundle exec rails server
```

### Executando via Docker

```bash
docker compose up
```

### Executando testes

```bash
bundle exec rspec path_do_arquivo_de_teste
```

---

## Documentação da API

### Usuários (`Users`)

#### `GET /api/v1/users`

- **Descrição:** Lista todos os usuários. Suporta paginação via query param `page`.
- **Params:** `page` (opcional)
- **Request Body:** Nenhum
- **Response Body:**
```json
[
  {
    "id": "1a2b3c4d-1234-5678-9101-abcdef123456",
    "name": "João Silva",
    "email": "joao.silva@example.com"
  },
  {
    "id": "2b3c4d5e-2345-6789-1011-bcdef2345678",
    "name": "Maria Oliveira",
    "email": "maria.oliveira@example.com"
  }
]
```
- **Status code:** 200

#### `GET /api/v1/users/:id`

- **Descrição:** Retorna um usuário específico.
- **Request Body:** Nenhum
- **Response Body:**
```json
{
  "id": "1a2b3c4d-1234-5678-9101-abcdef123456",
  "name": "João Silva",
  "email": "joao.silva@example.com"
}
```
- **Status code:** 200

#### `POST /api/v1/users`

- **Descrição:** Cria um novo usuário.
- **Request Body:**
```json
{
  "user": {
    "name": "Pedro Santos",
    "email": "pedro.santos@example.com"
  }
}
```
- **Response Body:**
```json
{
  "id": "3c4d5e6f-3456-7891-0111-cdef34567890",
  "name": "Pedro Santos",
  "email": "pedro.santos@example.com"
}
```
- **Status code:** 201

#### `PUT /api/v1/users/:id`

- **Descrição:** Atualiza um usuário existente.
- **Request Body:**
```json
{
  "user": {
    "name": "Pedro S. Oliveira",
    "email": "pedro.oliveira@example.com"
  }
}
```
- **Response Body:** Nenhum
- **Status code:** 204

#### `DELETE /api/v1/users/:id`

- **Descrição:** Remove um usuário.
- **Request Body:** Nenhum
- **Response Body:** Nenhum
- **Status code:** 204

#### `GET /api/v1/users/:id/time_registers`

- **Descrição:** Lista todos os registros de ponto do usuário.
- **Request Body:** Nenhum
- **Response Body:**
```json
[
  {
    "id": "1111aaaa-2222-bbbb-3333-cccc4444dddd",
    "user_id": "1a2b3c4d-1234-5678-9101-abcdef123456",
    "clock_in": "2025-09-12T08:00:00Z",
    "clock_out": "2025-09-12T12:00:00Z"
  },
  {
    "id": "5555eeee-6666-ffff-7777-gggg8888hhhh",
    "user_id": "1a2b3c4d-1234-5678-9101-abcdef123456",
    "clock_in": "2025-09-12T13:00:00Z",
    "clock_out": "2025-09-12T18:00:00Z"
  }
]
```
- **Status code:** 200

---

### Registros de Horário (`TimeRegisters`)

#### `GET /api/v1/time_registers`

- **Descrição:** Lista todos os registros de ponto.
- **Params:** `page` (opcional)
- **Request Body:** Nenhum
- **Response Body:**
```json
[
  {
    "id": "1111aaaa-2222-bbbb-3333-cccc4444dddd",
    "user_id": "1a2b3c4d-1234-5678-9101-abcdef123456",
    "clock_in": "2025-09-12T08:00:00Z",
    "clock_out": "2025-09-12T12:00:00Z"
  }
]
```
- **Status code:** 200

#### `GET /api/v1/time_registers/:id`

- **Descrição:** Retorna um registro específico.
- **Request Body:** Nenhum
- **Response Body:**
```json
{
  "id": "1111aaaa-2222-bbbb-3333-cccc4444dddd",
  "user_id": "1a2b3c4d-1234-5678-9101-abcdef123456",
  "clock_in": "2025-09-12T08:00:00Z",
  "clock_out": "2025-09-12T12:00:00Z"
}
```
- **Status code:** 200

#### `POST /api/v1/time_registers`

- **Descrição:** Cria um novo registro.
- **Request Body:**
```json
{
  "time_register": {
    "user_id": "3c4d5e6f-3456-7891-0111-cdef34567890",
    "clock_in": "2025-09-15T08:30:00Z",
    "clock_out": "2025-09-15T12:30:00Z"
  }
}
```
- **Response Body:**
```json
{
  "id": "9999iiii-0000-jjjj-1111-kkkk2222llll",
  "user_id": "3c4d5e6f-3456-7891-0111-cdef34567890",
  "clock_in": "2025-09-15T08:30:00Z",
  "clock_out": "2025-09-15T12:30:00Z"
}
```
- **Status code:** 201

#### `PUT /api/v1/time_registers/:id`

- **Descrição:** Atualiza um registro.
- **Request Body:**
```json
{
  "time_register": {
    "clock_in": "2025-09-15T09:00:00Z",
    "clock_out": "2025-09-15T13:00:00Z"
  }
}
```
- **Response Body:** Nenhum
- **Status code:** 204

#### `DELETE /api/v1/time_registers/:id`

- **Descrição:** Remove um registro.
- **Request Body:** Nenhum
- **Response Body:** Nenhum
- **Status code:** 204

---

## Tarefa Rake para popular usuários

```bash
bundle exec rails users:populate
```

- Cria 100 usuários e 20 registros de ponto para cada.
- Evita criar duplicados.
- Relatórios de criação e skips são exibidos no console.

---

## Arquitetura do Projeto

- **Controllers:** `Api::V1::UsersController` e `Api::V1::TimeRegistersController`
- **Models:** `User`, `TimeRegister`
- **Serializers:** `ActiveModel::Serializer`
- **Paginação:** `Pagy`
- **Fake Data:** `Faker`
- **Task Rake:** `users:populate`
- **Banco:** PostgreSQL com Docker
- **Padrões:** RESTful API, MVC

---

