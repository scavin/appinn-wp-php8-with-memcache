FROM wordpress:php8.1-fpm

MAINTAINER Scavin <scavin@appinn.com>

RUN apt-get update \
  && apt-get -y install wget zlib1g-dev
RUN wget https://pecl.php.net/get/memcache-8.0.tgz \
  && tar zxvf memcache-8.0.tgz \
  && docker-php-source extract \
  && rm memcache-8.0.tgz && mv memcache-8.0 /usr/src/php/ext/memcache \
  && docker-php-ext-install memcache
