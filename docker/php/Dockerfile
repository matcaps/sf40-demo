FROM php:7.1-fpm

ENV GOSU_VERSION 1.10

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN apt-get update \
    && apt-get install -y \
    && curl -L -s -o /bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }') \
    && chmod +x /bin/gosu \
    && docker-php-ext-install opcache pdo_mysql \
    && mkdir -p /home/.composer \
    && addgroup bar \
    && adduser --gecos "" --home=/home --shell=/bin/bash --ingroup=bar --disabled-password --quiet foo \
    && chown -R foo:bar /home/.composer \
    && apt-get clean

COPY php.ini /usr/local/etc/php/conf.d/
COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod a+x /usr/bin/entrypoint.sh

WORKDIR /srv

ENTRYPOINT ["entrypoint.sh"]
