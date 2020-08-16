#!/bin/bash

set -eux

apt-get -y update

apt-get -y upgrade

PHP_VERSION=7.4.9
PHP_HASH=c0c657b5769bc463f5f028b1f4fef8814d98ecf3459a402a9e30d41d68b2323e

COMPOSER_VERSION=1.10.10
COMPOSER_HASH=8f16aa77b1236ed40855d8d141c0a939d108a939c8e73f9f32eadd3f05f181b9

NGINX_VERSION=1.19.2
NGINX_HASH=7c1f7bb13e79433ee930c597d272a64bc6e30c356a48524f38fd34fa88d62473


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
libssl-dev                      \
zlib1g-dev                      \
libpcre3-dev                    \
libedit-dev                     \
libeditline-dev                 \
libgd-dev                       \
libwebp-dev                     \
libfreetype6-dev                \
libpng-dev                      \
libjpeg-dev                     \
libxml2-dev                     \
libxslt1-dev                    \
libargon2-0-dev                 \
libbz2-dev                      \
libcurl4-openssl-dev            \
libgmp-dev                      \
libreadline-dev                 \
libicu-dev                      \
libzip-dev                      \
libtidy-dev                     \
libevent-dev                    \
libgeoip-dev                    \
libsodium-dev                   \
chromium-browser                \
fonts-droid-fallback            \
ttf-wqy-zenhei                  \
ttf-wqy-microhei                \
fonts-arphic-ukai               \
fonts-arphic-uming

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



cd /usr/local/src/php-${PHP_VERSION}
./configure --prefix=/usr/local/php \
--enable-fpm \
--with-fpm-user=root \
--with-fpm-group=root \
--disable-short-tags \
--with-libxml-dir \
--with-openssl \
--with-openssl-dir \
--with-pcre-regex \
--with-pcre-dir \
--with-pcre-jit \
--with-zlib \
--with-zlib-dir \
--enable-bcmath \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif \
--with-gd \
--with-freetype-dir \
--with-webp-dir \
--with-jpeg-dir \
--with-png-dir \
--with-xpm-dir \
--enable-gd-jis-conv \
--with-gettext \
--with-gmp \
--with-mhash \
--enable-intl \
--with-icu-dir=/usr \
--enable-mbstring \
--enable-mysqlnd \
--enable-pdo \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--enable-pcntl \
--with-readline \
--enable-soap \
--enable-sockets \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-shmop \
--enable-zip \
--enable-zend-test \
--with-xsl \
--with-tidy \
--with-xmlrpc \
--with-libzip \
--with-iconv-dir \
--with-pear \
--with-sodium \
--with-password-argon2

make
make install

# shellcheck disable=SC2164
cd /usr/local/src

wget https://raw.githubusercontent.com/mobyapps/composed/master/aliyunconf/php-fpm.conf
wget https://raw.githubusercontent.com/mobyapps/composed/master/aliyunconf/www.conf
wget https://raw.githubusercontent.com/mobyapps/composed/master/aliyunconf/php.ini

/bin/cp  ./php-fpm.conf  /usr/local/php/etc/php-fpm.conf
/bin/cp  ./www.conf      /usr/local/php/etc/php-fpm.d/www.conf
/bin/cp  ./php.ini       /usr/local/php/lib/php.ini

/usr/local/php/bin/php -v

/usr/local/php/sbin/php-fpm --allow-to-run-as-root
sleep 3s
# shellcheck disable=SC2046
# shellcheck disable=SC2006
kill -INT `cat /usr/local/php/var/run/php-fpm.pid`



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

mkdir /usr/local/nginx/vhosts

# shellcheck disable=SC2164
cd /usr/local/src

wget https://raw.githubusercontent.com/mobyapps/composed/master/aliyunconf/nginx.conf

/bin/cp  ./nginx.conf  /usr/local/nginx/conf/nginx.conf

/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx
sleep 3s
/usr/local/nginx/sbin/nginx -s stop


# shellcheck disable=SC2129
echo '' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'export PATH="$PATH:/usr/local/php/bin:/usr/local/php/sbin"' >> ~/.bashrc
# shellcheck disable=SC2016
echo 'export PATH="$PATH:/usr/local/nginx/sbin"' >> ~/.bashrc


apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /usr/local/src/*
