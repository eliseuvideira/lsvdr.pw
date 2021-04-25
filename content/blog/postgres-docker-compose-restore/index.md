---
title: Restore Postgres Backup to a Docker Compose Postgres Container
date: 2021-04-24T23:55:50.637Z
description: Simple script to restore a postgres backup into a postgres container that runs with docker-compose
---

## Requirements

- Docker
- Docker Compose
- Postgres Container Running with Docker Compose
- Backup .sql file

## How to do it

Assuming a .env file with the following contents exists on the same folder as docker-compose

`embed:example.env`

This also assumes that postgres runs under service key "postgres" on docker-compose.yml file

Create a new file named restore.sh and make it executable

```shell
touch restore.sh
chmod +x restore.sh
```

Paste the following content into restore.sh

`embed:restore.sh`

Now run the script

```shell
./restore.sh /path/to/backup.sql
```

Connect to database and check the restore

```shell
docker-compose exec postgres psql -U <user> -p <port> -d <db>
```

```sql
select * from pg_tables;
```
