FROM php:8.3-rc-apache

LABEL org.opencontainers.image.title="OWA" \
      org.opencontainers.image.description="Open Web Analytics" \
      org.opencontainers.image.version="1.7.8" \
      org.opencontainers.image.vendor="flavien.io" \
      org.opencontainers.image.maintainer="Flavien PERIER <perier@flavien.io>" \
      org.opencontainers.image.url="https://github.com/flavien-perier/dockerfile-owa" \
      org.opencontainers.image.source="https://github.com/flavien-perier/dockerfile-owa" \
      org.opencontainers.image.licenses="MIT"
      
ARG OWA_VERSION="1.7.8"

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

RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev zlib1g-dev libpng-dev libxml2-dev && \
    docker-php-ext-install curl gd dom intl mysqli && \
    tar xf /var/www/html/owa.tar && \
    rm -f /var/www/html/owa.tar && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R www-data:www-data /var/www/html

COPY --chown=www-data:www-data --chmod=400 owa-config.php /var/www/html/owa-config.php