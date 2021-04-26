---
title: Using aws-cli as a Docker Container
date: 2021-04-26T01:14:54.216Z
description: Zero install way to run aws-cli commands
---

## Requirements

- Docker
- Docker Compose
- AWS Account

## How to do it

Create a .env file into a folder

```shell
mkdir aws-cli
cd aws-cli
touch .env
```

Add the following variables to it, filling your credentials instead

```shell
AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_DEFAULT_REGION=us-west-2
```

Run cli commands using docker

```shell
docker run --rm -i --env-file ./.env amazon/aws-cli sts get-caller-identity
```

You can easily setup a s3 storage upload by sharing a volume with the running container

```shell
docker run --rm -i --env-file ./.env -v "/path/to/host/folder:/root/folder" amazon/aws-cli s3 cp "/root/folder/filename" "/aws/path"
```

Once it finishes running the container gets destroyed, leaving no traces behind
