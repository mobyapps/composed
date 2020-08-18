FROM phusion/baseimage:focal-1.0.0alpha1-amd64

LABEL maintainer="charescape@outlook.com"

ENV PHP_VERSION         7.4.9
ENV PHP_HASH            c0c657b5769bc463f5f028b1f4fef8814d98ecf3459a402a9e30d41d68b2323e

ENV COMPOSER_VERSION    1.10.10
ENV COMPOSER_HASH       8f16aa77b1236ed40855d8d141c0a939d108a939c8e73f9f32eadd3f05f181b9

ENV NGINX_VERSION       1.19.2
ENV NGINX_HASH          7c1f7bb13e79433ee930c597d272a64bc6e30c356a48524f38fd34fa88d62473

COPY ./runapp.sh  /etc/my_init.d/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/php.ini           /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/php-fpm.conf      /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/www.conf          /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/nginx.conf        /usr/local/src/

# see http://www.ruanyifeng.com/blog/2017/11/bash-set.html
RUN set -eux \
&& export DEBIAN_FRONTEND=noninteractive \
&& sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list \
&& sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list \
\
&& apt-get -y clean all         \
&& apt-get -y update            \
&& apt-get -y upgrade           \
&& apt-get -y clean all         \
&& apt-get -y update            \
&& apt-get -y upgrade           \
&& apt-get -y install build-essential \
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
libsqlite3-dev                  \
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
fonts-arphic-uming              \
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
libgeoip-dev                    \
\
&& chmod +x /etc/my_init.d/runapp.sh \
\
&& cd /usr/local/bin/ \
&& wget https://mirrors.aliyun.com/composer/composer.phar \
&& echo "${COMPOSER_HASH} *composer.phar" | shasum -a 256 --check \
&& COMPOSER_HASH_CHECK=$? \
&& if [ "$COMPOSER_HASH_CHECK" -ne "0" ]; then echo "composer.phar hash mismatch." && exit 1; fi \
\
&& chmod +x /usr/local/bin/composer.phar \
\
&& cd /usr/local/src \
\
&& wget https://mirrors.sohu.com/php/php-${PHP_VERSION}.tar.gz \
&& echo "${PHP_HASH} *php-${PHP_VERSION}.tar.gz" | shasum -a 256 --check \
&& PHP_HASH_CHECK=$? \
&& if [ "$PHP_HASH_CHECK" -ne "0" ]; then echo "php-${PHP_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& wget https://mirrors.sohu.com/nginx/nginx-${NGINX_VERSION}.tar.gz \
&& echo "${NGINX_HASH} *nginx-${NGINX_VERSION}.tar.gz" | shasum -a 256 --check \
&& NGINX_HASH_CHECK=$? \
&& if [ "$NGINX_HASH_CHECK" -ne "0" ]; then echo "nginx-${NGINX_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& tar -zxf php-${PHP_VERSION}.tar.gz \
&& tar -zxf nginx-${NGINX_VERSION}.tar.gz \
\
&& cd /usr/local/src/php-${PHP_VERSION} \
&& ./configure --prefix=/usr/local/php \
--enable-fpm \
--with-fpm-user=root \
--with-fpm-group=root \
--disable-short-tags \
--with-openssl \
--with-openssl-dir \
--with-pcre-jit \
--with-zlib \
--with-zlib-dir \
--enable-bcmath \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif \
--enable-gd \
--with-freetype \
--with-webp \
--with-jpeg \
--with-xpm \
--enable-gd-jis-conv \
--with-gettext \
--with-gmp \
--with-mhash \
--enable-intl \
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
--with-zip \
--enable-zend-test \
--with-xsl \
--with-tidy \
--with-xmlrpc \
--with-iconv-dir \
--with-pear \
--with-sodium \
--with-password-argon2 \
\
&& make \
&& sleep  3s \
&& make install \
\
&& cd /usr/local/src \
&& yes | cp ./php-fpm.conf /usr/local/php/etc/php-fpm.conf \
&& yes | cp ./www.conf     /usr/local/php/etc/php-fpm.d/www.conf \
&& yes | cp ./php.ini      /usr/local/php/lib/php.ini \
\
&& /usr/local/php/bin/php -v \
&& sleep  3s \
&& /usr/local/php/sbin/php-fpm --allow-to-run-as-root \
&& sleep  3s \
&& kill -INT `cat /usr/local/php/var/run/php-fpm.pid` \
\
&& cd /usr/local/src \
\
&& cd /usr/local/src/nginx-${NGINX_VERSION} \
&& ./configure --prefix=/usr/local/nginx \
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
--with-http_xslt_module=dynamic \
\
&& make \
&& sleep  3s \
&& make install \
\
&& mkdir /usr/local/nginx/gitrepos \
\
&& cd /usr/local/src \
&& yes | cp ./nginx.conf  /usr/local/nginx/conf/nginx.conf \
\
&& /usr/local/nginx/sbin/nginx -t \
&& /usr/local/nginx/sbin/nginx \
&& sleep 3s \
&& /usr/local/nginx/sbin/nginx -s stop \
\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& rm -rf /usr/local/src/*

EXPOSE 80 443 9000

CMD ["/sbin/my_init"]

# source ~/.bashrc
