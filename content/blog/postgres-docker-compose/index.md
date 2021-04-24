---
title: Postgres Using Docker Compose
date: 2021-04-24T19:27:58.381Z
description: Deploy a production ready postgres database using docker-compose
---

## Requirements

- Docker
- Docker Compose

## How to do it

### Create a new folder

```shell
mkdir postgresdb
cd postgresdb
touch .env docker-compose.yml
```

##### .env file

`embed:example.env`

##### docker-compose.yml file

`embed:docker-compose.yml`

### Run docker-compose

```shell
docker-compose up -d
```

### Test your database

```shell
docker-compose exec postgres psql -U <user> -p <port> -d <db>
```

```sql
select * from pg_database;
select * from pg_tables;
```
