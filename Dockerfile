ARG VERSION=6-php8.3-fpm
FROM docker.io/wordpress:${VERSION}

USER root

RUN apt-get update && apt-get install -y --no-install-recommends $PHPIZE_DEPS \
  && pecl install -o -f redis \
  && rm -rf /tmp/pear \
  && docker-php-ext-enable redis \
  && docker-php-ext-install opcache \
  && apt-get purge -y --auto-remove $PHPIZE_DEPS \
  && rm -rf /var/lib/apt/lists/*

USER www-data
