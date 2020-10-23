![license](https://badgen.net/github/license/flavien-perier/dockerfile-owa)
[![docker pulls](https://badgen.net/docker/pulls/flavienperier/owa)](https://hub.docker.com/r/flavienperier/owa)
[![ci status](https://badgen.net/github/checks/flavien-perier/dockerfile-owa)](https://github.com/flavien-perier/dockerfile-owa)

# Dockerfile OWA

Dockerfile for [Open Web Analytics](http://www.openwebanalytics.com/).

## Env variables

- OWA_DB_TYPE
- OWA_DB_HOST
- OWA_DB_NAME
- OWA_DB_USER
- OWA_DB_PASSWORD
- OWA_PUBLIC_URL
- OWA_NONCE_KEY
- OWA_NONCE_SALT
- OWA_AUTH_KEY
- OWA_AUTH_SALT
- OWA_ERROR_HANDLER
- OWA_LOG_PHP_ERRORS

## Ports

- 80: HTTP

## Docker-compose example

```yaml
owa:
  image: flavienperier/owa
  container_name: owa
  restart: always
  links:
    - db-owa
  environment:
    OWA_PUBLIC_URL: http://analytics.flavien.io/
    OWA_DB_HOST: db-owa:3306
    OWA_DB_NAME: owa
    OWA_DB_USER: owa
    OWA_DB_PASSWORD: password
    OWA_NONCE_KEY: nonce_key
    OWA_NONCE_SALT: nonce_salt
    OWA_AUTH_KEY: auth_key
    OWA_AUTH_SALT: auth_salt

db-owa:
  image: mariadb
  container_name: db-owa
  restart: always
  volumes:
    - ./documents/owa/db:/var/lib/mysql
  environment:
    MYSQL_DATABASE: owa
    MYSQL_USER: owa
    MYSQL_PASSWORD: password
    MYSQL_ROOT_PASSWORD: password
```
