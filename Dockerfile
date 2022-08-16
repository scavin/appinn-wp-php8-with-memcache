FROM wordpress:php8.1-fpm

MAINTAINER Scavin <scavin@appinn.com>

RUN apt-get update \
  && apt-get -y install wget zlib1g-dev
RUN wget https://pecl.php.net/get/memcache-8.0.tgz \
  && tar zxvf memcache-8.0.tgz \
  && docker-php-source extract \
  && rm memcache-8.0.tgz && mv memcache-8.0 /usr/src/php/ext/memcache \
  && docker-php-ext-install memcache

RUN set -eux; \
	docker-php-ext-enable opcache; \
	{ \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
        echo 'opcache.jit_buffer_size=32M'; \
        echo 'opcache.jit=1235'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini
