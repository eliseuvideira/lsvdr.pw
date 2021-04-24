---
title: Postgres Using Docker Compose
date: 2021-04-24T19:27:58.381Z
description: Deploy a production ready postgres database using docker-compose
---

## Requirements

- Docker
- Docker Compose

## How to do it

Create a new folder to store the config files

```shell
mkdir postgresdb
cd postgresdb
touch .env docker-compose.yml
```

The .env file should contain the following variables

`embed:example.env`

Paste this content into docker-compose.yml

`embed:docker-compose.yml`

Try running docker-compose

```shell
docker-compose up -d
```

Test a database connection

```shell
docker-compose exec postgres psql -U <user> -p <port> -d <db>
```

Run queries

```sql
select * from pg_database;
select * from pg_tables;
```
