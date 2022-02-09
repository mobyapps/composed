#!/bin/bash

set -eux

apt -y update

apt -y upgrade

PHP_VERSION=5.6.40
PHP_HASH=56fb9878d12fdd921f6a0897e919f4e980d930160e154cbde2cc6d9206a27cac

COMPOSER_VERSION=1.10.15
COMPOSER_HASH=a69df12e86a0a18fbedfc91a33d5f9acc5cf939576e0258326074fc1b2ee1aea

NGINX_VERSION=1.19.3
NGINX_HASH=91e5b74fa17879d2463294e93ad8f6ffc066696ae32ad0478ffe15ba0e9e8df0

# apt -y install build-essential \
# zlib1g-dev                      \
# libedit-dev                     \
# libeditline-dev                 \
# libgd-dev                       \
# libicu-dev                      \
# libevent-dev                    \
# chromium-browser                \
# fonts-droid-fallback            \
# ttf-wqy-zenhei                  \
# ttf-wqy-microhei                \
# fonts-arphic-ukai               \
# fonts-arphic-uming

apt-get -y install build-essential \
autoconf                        \
pkg-config                      \
wget                            \
perl                            \
git                             \
curl                            \
re2c                            \
bison                           \
zip                             \
socat                           \
libtool                         \
libxml2-dev                     \
libssl-dev                      \
libcurl4-openssl-dev            \
libsqlite3-dev                  \
libbz2-dev                      \
libgmp-dev                      \
libonig-dev                     \
libreadline-dev                 \
libsodium-dev                   \
libargon2-0-dev                 \
libtidy-dev                     \
libxslt1-dev                    \
libpng-dev                      \
libwebp-dev                     \
libjpeg-dev                     \
libxpm-dev                      \
libfreetype6-dev                \
libzip-dev                      \
libpcre3-dev                    \
libmcrypt-dev                   \
libpspell-dev                   \
librecode-dev                   \
libgeoip-dev

# shellcheck disable=SC2164
cd /usr/local/bin/

wget https://mirrors.aliyun.com/composer/composer.phar

echo "${COMPOSER_HASH} *composer.phar" | shasum -a 256 --check

COMPOSER_HASH_CHECK=$?

if [ "${COMPOSER_HASH_CHECK}" -ne "0" ]; then echo "composer.phar ${COMPOSER_VERSION} hash mismatch." && exit 1; fi

chmod +x /usr/local/bin/composer.phar



# shellcheck disable=SC2164
cd /usr/local/src

wget https://mirrors.sohu.com/php/php-${PHP_VERSION}.tar.gz

echo "${PHP_HASH} *php-${PHP_VERSION}.tar.gz" | shasum -a 256 --check

PHP_HASH_CHECK=$?

if [ "${PHP_HASH_CHECK}" -ne "0" ]; then echo "php-${PHP_VERSION}.tar.gz hash mismatch." && exit 1; fi

tar -zxf php-${PHP_VERSION}.tar.gz


wget https://mirrors.sohu.com/nginx/nginx-${NGINX_VERSION}.tar.gz

echo "${NGINX_HASH} *nginx-${NGINX_VERSION}.tar.gz" | shasum -a 256 --check

NGINX_HASH_CHECK=$?

if [ "${NGINX_HASH_CHECK}" -ne "0" ]; then echo "nginx-${NGINX_VERSION}.tar.gz hash mismatch." && exit 1; fi

tar -zxf nginx-${NGINX_VERSION}.tar.gz

ln -s /usr/include/x86_64-linux-gnu/curl /usr/include/
ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
ln -s /usr/bin/pkg-config /usr/bin/freetype-config

mkdir -p /var/www

cd /usr/local/src/php-${PHP_VERSION}
./configure --prefix=/usr/local/php \
--enable-fpm \
--with-fpm-user=www-data \
--with-fpm-group=www-data \
--enable-phpdbg \
--disable-short-tags \
--with-libxml-dir \
--with-openssl \
--with-openssl-dir \
--with-pcre-regex \
--with-pcre-dir \
--with-zlib \
--with-zlib-dir \
--enable-bcmath \
--with-bz2 \
--enable-calendar \
--with-curl \
--with-enchant \
--enable-exif \
--enable-ftp \
--with-gd \
--with-jpeg-dir \
--with-xpm-dir \
--with-png-dir \
--with-freetype-dir \
--enable-gd-native-ttf \
--enable-gd-jis-conv \
--with-gettext \
--with-gmp \
--with-mhash \
--enable-mbstring \
--with-mcrypt \
--with-mysql \
--with-mysqli \
--with-pdo-mysql \
--enable-opcache \
--enable-pcntl \
--with-readline \
--enable-zip \
--enable-mysqlnd \
--enable-pdo \
--with-pspell \
--with-recode \
--enable-soap \
--enable-sockets \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-shmop \
--with-xsl \
--with-tidy \
--with-xmlrpc \
--with-iconv-dir \
--with-pear

make
make install

# shellcheck disable=SC2164
cd /usr/local/src

wget https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/php-fpm.conf
wget https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/www.conf
wget https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/php.ini

/bin/cp  ./php-fpm.conf  /usr/local/php/etc/php-fpm.conf
/bin/cp  ./www.conf      /usr/local/php/etc/php-fpm.d/www.conf
/bin/cp  ./php.ini       /usr/local/php/lib/php.ini


chown -R www-data:www-data /usr/local/php

/usr/local/php/bin/php -v
/usr/local/php/sbin/php-fpm
sleep 3s
# shellcheck disable=SC2046
# shellcheck disable=SC2006
kill -INT `cat /usr/local/php/var/run/php-fpm.pid`

chown -R www-data:www-data /usr/local/php



# shellcheck disable=SC2164
cd /usr/local/src/nginx-${NGINX_VERSION}
./configure --prefix=/usr/local/nginx \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_stub_status_module \
--without-mail_pop3_module \
--without-mail_imap_module \
--without-mail_smtp_module \
--with-stream=dynamic \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_ssl_preread_module \
--with-pcre \
--with-pcre-jit \
--with-http_geoip_module=dynamic \
--with-stream_geoip_module=dynamic \
--with-http_xslt_module=dynamic

make
make install

mkdir -p /var/www/gitrepos
chown -R www-data:www-data /var/www

# shellcheck disable=SC2164
cd /usr/local/src

wget https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/nginx.conf
/bin/cp  ./nginx.conf  /usr/local/nginx/conf/nginx.conf


chown -R www-data:www-data /usr/local/nginx

/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx
sleep 3s
/usr/local/nginx/sbin/nginx -s stop

chown -R www-data:www-data /usr/local/nginx


# shellcheck disable=SC2129
echo '' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'export PATH="$PATH:/usr/local/php/bin:/usr/local/php/sbin"' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'export PATH="$PATH:/usr/local/nginx/sbin"' >> ~/.bashrc
echo '' >> ~/.bashrc


# apt clean
# rm -rf /var/lib/apt/lists/*
# rm -rf /tmp/*
# rm -rf /var/tmp/*
rm -rf /usr/local/src/*
