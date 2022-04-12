# Docker Compose - Nginx and WordPress

Use WordPress locally with Docker using docker-compose

## Contents

- nginx
- php 8.0
- wordpress
- mariadb
- phpmyadmin
- wpcli
- mailhog
- redis
- Custom domain for example `myapp.local`
- CLI script to create a SSL certificate

## Instructions

### Requirements

- [Docker](https://www.docker.com/get-started)
- [mkcert](https://github.com/FiloSottile/mkcert) for creating the SSL cert.

Install mkcert:

```
brew install mkcert
brew install nss # if you use Firefox
```

### 1. Setup Environment variables

Edit `.env` filte to your preferences.

### 2. Use HTTPS with a custom domain

```shell
cd cli
./create-cert.sh
```

This script will create a locally-trusted development certificates. It requires no configuration.

> mkcert needs to be installed like described in Requirements. Read more for [Windows](https://github.com/FiloSottile/mkcert#windows) and [Linux](https://github.com/FiloSottile/mkcert#linux)

Make sure your `/etc/hosts` file has a record for used domains.

```
sudo nano /etc/hosts
```

Add your selected domain like this:

```
127.0.0.1 myapp.local
```

### 3. Run

```shell
docker-compose up -d
```
