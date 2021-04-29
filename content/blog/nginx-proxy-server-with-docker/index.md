---
title: Building an Nginx Proxy Server
date: 2021-04-29T00:52:28.749Z
description: Easy deploy and maintain nginx proxy server with Docker and Certbot
---

## Requirements

- Docker
- Docker Compose

## How to do it

Create a new folder to store the config files

```shell
mkdir nginx-proxy-server
cd nginx-proxy-server
touch docker-compose.yml
```

Paste the following content into docker-compose.yml

```yml
version: "3"

services:
  nginx:
    image: nginx:alpine
    ports:
      - 80:80
      - 443:443
    restart: always
    volumes:
      - ./data/nginx:/etc/nginx/conf.d
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot

  certbot:
    image: certbot/certbot
    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
    restart: always
    volumes:
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot
```

Create a `default.conf` nginx file

```shell
mkdir -p data/nginx
touch default.conf
```

Paste the following

```
server_tokens off;

include /etc/nginx/conf.d/domains/*.conf;
```

Create a create-cert script into the root directory

```shell
curl https://raw.githubusercontent.com/eliseuvideira/create-nginx-server/master/create-cert > create-cert
chmod +x create-cert
```

The content of the script is a modified version of the script made by this post: https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71

Now run docker-compose

```shell
docker-compose up -d
```

To add a new domain into the list of domains, run `./create-cert`, if you run without arguments it will print help message

```shell
./create-cert subdomain.domain.com myemail@email.com http://192.168.13.37 0
```

The first parameter is the domain you wish to add to proxy server, the second is a valid email for letsencrypt, the third is to where nginx should reverse-proxy and the fourth is a flag to know if certbot should run on staging or not (1 for staging, 0 for production).
