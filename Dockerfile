FROM phusion/baseimage:0.11

LABEL maintainer="charescape@outlook.com"

ENV PHP_VERSION         7.3.13
ENV PHP_HASH            9cf835416a3471d7e6615e9288e76813d55ffaf60e0aa9ce74884a7c228cb6dd

ENV MEMCACHED_VERSION   1.5.20
ENV MEMCACHED_HASH      cfd7b023a9cefe7ae8a67184f51d841dbbf97994ed0e8a55e31ee092320ea1e4

ENV COMPOSER_VERSION    1.9.1
ENV COMPOSER_HASH       1f210b9037fcf82670d75892dfc44400f13fe9ada7af9e787f93e50e3b764111

ENV NGINX_VERSION       1.17.6
ENV NGINX_HASH          3cb4a5314dc0ab0a4e8a7b51ae17c027133417a45cc6c5a96e3dd80141c237b6

COPY ./startserv.sh                   /etc/my_init.d/
COPY ./conf/php.ini                   /usr/local/src/
COPY ./conf/php-fpm.conf              /usr/local/src/
COPY ./conf/www.conf                  /usr/local/src/
COPY ./conf/nginx.conf                /usr/local/src/

# see http://www.ruanyifeng.com/blog/2017/11/bash-set.html
RUN set -eux \
&& export DEBIAN_FRONTEND=noninteractive \
&& sed -i 's/http:\/\/archive.ubuntu.com/https:\/\/mirrors.cloud.tencent.com/' /etc/apt/sources.list \
&& sed -i 's/http:\/\/security.ubuntu.com/https:\/\/mirrors.cloud.tencent.com/' /etc/apt/sources.list \
&& sed -i 's/https:\/\/archive.ubuntu.com/https:\/\/mirrors.cloud.tencent.com/' /etc/apt/sources.list \
&& sed -i 's/https:\/\/security.ubuntu.com/https:\/\/mirrors.cloud.tencent.com/' /etc/apt/sources.list \
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
\
&& groupadd group7 \
&& useradd -g group7 -M -d /usr/local/php user7 -s /sbin/nologin \
\
&& chmod +x /etc/my_init.d/startserv.sh \
\
&& cd /usr/local/bin/ \
&& wget https://mirrors.aliyun.com/composer/composer.phar \
&& echo "${COMPOSER_HASH} *composer.phar" | shasum -a 256 --check \
&& COMPOSER_HASH_CHECK=$? \
&& if [ "$COMPOSER_HASH_CHECK" -ne "0" ]; then echo "composer.phar hash mismatch." && exit 1; fi \
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
&& wget https://memcached.org/files/memcached-${MEMCACHED_VERSION}.tar.gz \
&& echo "${MEMCACHED_HASH} *memcached-${MEMCACHED_VERSION}.tar.gz" | shasum -a 256 --check \
&& MEMCACHED_HASH_CHECK=$? \
&& if [ "$MEMCACHED_HASH_CHECK" -ne "0" ]; then echo "memcached-${MEMCACHED_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& tar -zxf php-${PHP_VERSION}.tar.gz \
&& tar -zxf nginx-${NGINX_VERSION}.tar.gz \
&& tar -zxf memcached-${MEMCACHED_VERSION}.tar.gz \
\
&& cd /usr/local/src/php-${PHP_VERSION} \
&& ./configure --prefix=/usr/local/php \
--enable-fpm \
--with-fpm-user=user7 \
--with-fpm-group=group7 \
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
--with-password-argon2 \
\
&& make && make install \
\
&& cd /usr/local/src \
&& yes | cp ./php-fpm.conf /usr/local/php/etc/php-fpm.conf \
&& yes | cp ./www.conf     /usr/local/php/etc/php-fpm.d/www.conf \
&& yes | cp ./php.ini      /usr/local/php/lib/php.ini \
\
&& chown -R user7:group7  /usr/local/php \
&& /usr/local/php/sbin/php-fpm \
&& sleep  3s \
&& kill -INT `cat /usr/local/php/var/run/php-fpm.pid` \
\
&& echo '' >> ~/.bashrc \
&& echo 'export PATH="$PATH:/usr/local/php/bin:/usr/local/php/sbin"' >> ~/.bashrc \
\
&& cd /usr/local/src \
\
&& cd /usr/local/src/memcached-${MEMCACHED_VERSION} \
&& ./configure --prefix=/usr/local/memcached \
--runstatedir=/usr/local/memcached/rsdir \
--datadir=/usr/local/memcached/ddir \
--enable-64bit \
--enable-seccomp \
--enable-tls \
\
&& make && make install \
\
&& echo '' >> ~/.bashrc \
&& echo 'export PATH="$PATH:/usr/local/memcached/bin"' >> ~/.bashrc \
\
&& cd /usr/local/src \
\
&& cd /usr/local/src/nginx-${NGINX_VERSION} \
&& ./configure --prefix=/usr/local/nginx \
--with-threads \
--with-file-aio \
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
&& make && make install \
\
&& mkdir /usr/local/nginx/vhosts \
&& mkdir /usr/local/nginx/vconfs \
&& mkdir /usr/local/nginx/vcerts \
\
&& cd /usr/local/src \
&& yes | cp ./nginx.conf  /usr/local/nginx/conf/nginx.conf \
\
&& chown -R user7:group7 /usr/local/nginx \
&& /usr/local/nginx/sbin/nginx -t \
&& /usr/local/nginx/sbin/nginx \
&& sleep 3s \
&& /usr/local/nginx/sbin/nginx -s stop \
\
&& echo '' >> ~/.bashrc \
&& echo 'export PATH="$PATH:/usr/local/nginx/bin:/usr/local/nginx/sbin"' >> ~/.bashrc \
\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& rm -rf /usr/local/src/*

EXPOSE 80 443

CMD ["/sbin/my_init"]

# source ~/.bashrc
