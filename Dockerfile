ARG VERSION=6-php8.1-fpm-alpine
FROM docker.io/wordpress:${VERSION}

USER root

RUN apk add --no-cache --update --virtual buildDeps $PHPIZE_DEPS \
  && pecl install -o -f redis \
  && rm -rf /tmp/pear \
  && docker-php-ext-enable redis \
  && apk del buildDeps

RUN docker-php-ext-install opcache

USER www-data
