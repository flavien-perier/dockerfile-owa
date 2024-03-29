FROM php:7.4-rc-apache

LABEL maintainer="Flavien PERIER <perier@flavien.io>" \
      version="1.0.0" \
      description="Open Web Analytics"

ARG OWA_VERSION="1.7.1"

ENV OWA_DB_TYPE="mysql" \
    OWA_DB_HOST="localhost:3306" \
    OWA_DB_NAME="owa" \
    OWA_DB_USER="owa" \
    OWA_DB_PASSWORD="owa" \
    OWA_PUBLIC_URL="http://localhost:80/" \
    OWA_NONCE_KEY="owanoncekey" \
    OWA_NONCE_SALT="owanoncesalt" \
    OWA_AUTH_KEY="owaauthkey" \
    OWA_AUTH_SALT="owaauthsalt" \
    OWA_ERROR_HANDLER="development" \
    OWA_LOG_PHP_ERRORS="false"

ADD --chown=www-data:www-data https://github.com/Open-Web-Analytics/Open-Web-Analytics/releases/download/${OWA_VERSION}/owa_${OWA_VERSION}_packaged.tar /var/www/html/owa.tar
COPY --chown=www-data:www-data owa-config.php /var/www/html/owa-config.php

RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev zlib1g-dev libpng-dev libxml2-dev && \
    docker-php-ext-install curl gd dom intl mysqli && \
    tar xf /var/www/html/owa.tar && \
    rm -f /var/www/html/owa.tar && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R www-data:www-data /var/www/html
