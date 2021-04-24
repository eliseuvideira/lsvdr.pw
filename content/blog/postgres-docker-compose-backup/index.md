---
title: Backup a Docker Compose Postgres Container
date: 2021-04-24T23:28:21.812Z
description: Simple script to backup a postgres container that runs with docker-compose
---

## Requirements

- Docker
- Docker Compose
- Postgres Container Running with Docker Compose

## How to do it

Assuming a .env file with the following contents exists on the same folder as docker-compose

`embed:example.env`

Create a new file named backup.sh and make it executable

```shell
touch backup.sh
chmod +x backup.sh
```

Paste the following content into backup.sh

`embed:backup.sh`

Now run the script

```shell
./backup.sh
```

The new backup will be on the folder backups
