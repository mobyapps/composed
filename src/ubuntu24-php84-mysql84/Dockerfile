FROM phusion/baseimage:noble-1.0.1

LABEL maintainer="charescape@outlook.com"

ENV TZ                 "Asia/Shanghai"

ENV CMAKE_DEB_ID           "Ubuntu"
ENV CMAKE_DEB_RELEASE      "24.04"
ENV CMAKE_DEB_CODENAME     "noble"

ENV MYSQL_MAIN_VERSION  "8.0"
ENV MYSQL_VERSION       "8.0.41-32"

ENV PHP_VERSION         "8.4.4"
ENV PHP_HASH            719551f50a81961f802aa9102bf4a1a0b5a315074330ab37bc8035a15f4be71b

ENV COMPOSER_VERSION    "2.8.6"
ENV COMPOSER_HASH       becc28b909d2cca563e7caee1e488063312af36b1f2e31db64f417723b8c4026

ENV OPENRESTY_VERSION   "1.27.1.1"
ENV OPENRESTY_HASH      79b071e27bdc143d5f401d0dbf504de4420070d867538c5edc2546d0351fd5c0

COPY src/ubuntu24-php84-mysql84/runapps.sh  /etc/my_init.d/
COPY src/ubuntu24-php84-mysql84/php.ini  /usr/local/src/
COPY src/ubuntu24-php84-mysql84/my.cnf  /usr/local/src/
COPY src/ubuntu24-php84-mysql84/php-fpm.conf  /usr/local/src/
COPY src/ubuntu24-php84-mysql84/www.conf  /usr/local/src/
COPY src/ubuntu24-php84-mysql84/openresty.conf  /usr/local/src/
COPY src/ubuntu24-php84-mysql84/install.php  /usr/local/src/
COPY src/php-crud-api.php  /usr/local/src/


# see http://www.ruanyifeng.com/blog/2017/11/bash-set.html
RUN set -eux \
&& export DEBIAN_FRONTEND=noninteractive \
\
&& free -m            \
\
&& apt -y update            \
&& apt -yq upgrade          \
&& apt -y autoremove        \
\
&& echo '' >> ~/.bashrc         \
&& echo '' >> ~/.bashrc         \
\
&& apt -y install curl \
&& curl -o- https://fastly.jsdelivr.net/gh/nvm-sh/nvm@0.40.2/install.sh | bash \
\
&& echo '' >> ~/.bashrc         \
&& echo '' >> ~/.bashrc         \
\
&& mkdir -p /var/www              \
&& mkdir -p /repos/bin/pipx              \
&& chown -R www-data:www-data /repos/bin \
\
&& apt -yq install tzdata build-essential \
sudo                            \
cmake                           \
make                            \
gcc                             \
autoconf                        \
pkg-config                      \
wget                            \
perl                            \
git                             \
git-lfs                         \
curl                            \
re2c                            \
bison                           \
zip                             \
p7zip-full                      \
socat                           \
zstd                            \
libtool                         \
dnsutils                        \
tree                            \
supervisor                      \
\
libxml2-dev                     \
libssl-dev                      \
libcurl4-openssl-dev            \
libnss3-tools                   \
libmaxminddb-dev                \
libpcre3-dev                    \
libxslt1-dev                    \
libgeoip-dev                    \
libcapstone-dev                 \
libsqlite3-dev                  \
libbz2-dev                      \
libpng-dev                      \
libavif-dev                     \
libwebp-dev                     \
libjpeg-dev                     \
libxpm-dev                      \
libfreetype6-dev                \
libgmp-dev                      \
libonig-dev                     \
libreadline-dev                 \
libsodium-dev                   \
libargon2-dev                   \
libtidy-dev                     \
libzip-dev                      \
libzstd-dev                     \
libtirpc-dev                    \
libedit-dev                     \
libevent-dev                    \
liblz4-dev                      \
liblzma-dev                     \
libsasl2-dev                    \
libpq-dev                       \
libexpat1-dev                   \
python3-dev                     \
pipx                            \
\
memcached                       \
libmemcached-tools              \
libmemcached-dev                \
\
gfortran                        \
libopenblas-dev                 \
liblapacke-dev                  \
\
imagemagick                     \
libvips42t64                    \
libvips-dev                     \
\
&& lsb_release -rs \
&& lsb_release -cs \
&& lsb_release -is \
\
&& PIPX_BIN_DIR=/repos/bin/pipx  pipx ensurepath \
\
&& echo '' >> ~/.bashrc         \
&& echo '' >> ~/.bashrc         \
\
&& PIPX_BIN_DIR=/repos/bin/pipx  pipx install 'markitdown[all]' \
&& chown -R www-data:www-data /repos/bin \
\
&& chmod +x /etc/my_init.d/runapps.sh \
\
&& cd /usr/local/src \
&& git clone --depth 1 --branch v0.2.4   https://github.com/vozlt/nginx-module-vts.git \
&& git clone --depth 1 --branch v1.2.12  https://github.com/winshining/nginx-http-flv-module.git \
&& git clone --depth 1 --branch master   https://github.com/leev/ngx_http_geoip2_module.git \
&& git clone --depth 1 --branch master   https://github.com/evanmiller/mod_zip.git \
&& git clone --depth 1 --branch 1.0.11   https://github.com/swoole/phpy.git \
\
&& cd /usr/local/bin/ \
&& wget --no-verbose https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar \
&& echo "${COMPOSER_HASH} *composer.phar" | shasum -a 256 --check \
&& COMPOSER_HASH_CHECK=$? \
&& if [ "$COMPOSER_HASH_CHECK" -ne "0" ]; then echo "composer.phar hash mismatch." && exit 1; fi \
\
&& mv /usr/local/bin/composer.phar /usr/local/bin/composer \
&& chmod +x /usr/local/bin/composer \
&& chown www-data:www-data /usr/local/bin/composer \
\
&& cd /usr/local \
&& wget --no-verbose https://curl.se/ca/cacert.pem \
&& wget --no-verbose https://curl.se/ca/cacert.pem.sha256 \
&& cat cacert.pem.sha256 | shasum -a 256 --check \
&& CACERT_HASH_CHECK=$? \
&& if [ "$CACERT_HASH_CHECK" -ne "0" ]; then echo "cacert.pem hash mismatch." && exit 1; fi \
&& rm cacert.pem.sha256 \
\
&& cd /usr/local/src \
\
&& wget --no-verbose https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz \
&& echo "${PHP_HASH} *php-${PHP_VERSION}.tar.gz" | shasum -a 256 --check \
&& PHP_HASH_CHECK=$? \
&& if [ "$PHP_HASH_CHECK" -ne "0" ]; then echo "php-${PHP_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& wget --no-verbose https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz \
&& echo "${OPENRESTY_HASH} *openresty-${OPENRESTY_VERSION}.tar.gz" | shasum -a 256 --check \
&& OPENRESTY_HASH_CHECK=$? \
&& if [ "$OPENRESTY_HASH_CHECK" -ne "0" ]; then echo "openresty-${OPENRESTY_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& wget --no-verbose https://downloads.percona.com/downloads/Percona-Server-${MYSQL_MAIN_VERSION}/Percona-Server-${MYSQL_VERSION}/source/tarball/percona-server-${MYSQL_VERSION}.tar.gz \
&& wget --no-verbose https://downloads.percona.com/downloads/Percona-Server-${MYSQL_MAIN_VERSION}/Percona-Server-${MYSQL_VERSION}/source/tarball/percona-server-${MYSQL_VERSION}.tar.gz.sha256sum \
&& cat percona-server-${MYSQL_VERSION}.tar.gz.sha256sum | shasum -a 256 --check \
&& MYSQL_HASH_CHECK=$? \
&& if [ "$MYSQL_HASH_CHECK" -ne "0" ]; then echo "percona-server-${MYSQL_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
\
&& tar -zxf percona-server-${MYSQL_VERSION}.tar.gz \
&& tar -zxf php-${PHP_VERSION}.tar.gz \
&& tar -zxf openresty-${OPENRESTY_VERSION}.tar.gz \
\
\
&& mkdir /var/www/mysql_server \
&& mkdir /var/www/mysql_server/datadir \
&& mkdir /var/www/mysql_server/sysconfdir \
&& mkdir /var/www/mysql_server/tmpdir \
\
&& mkdir -p /repos/ip_site \
&& chown -R www-data:www-data /var/www \
\
&& apt -y install libkrb5-dev \
&& apt -y install libsasl2-dev libsasl2-modules-gssapi-mit \
&& apt -y install libudev-dev \
&& apt -y install libldap2-dev \
&& apt -y install libfido2-dev \
\
&& mkdir /usr/local/src/percona-server-${MYSQL_VERSION}/build_tmp_dir \
&& cd /usr/local/src/percona-server-${MYSQL_VERSION}/build_tmp_dir \
&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DMYSQL_DATADIR=/var/www/mysql_server/datadir \
-DSYSCONFDIR=/var/www/mysql_server/sysconfdir \
-DTMPDIR=/var/www/mysql_server/tmpdir \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_0900_ai_ci \
-DMYSQL_TCP_PORT=3306 \
-DMYSQL_UNIX_ADDR=/var/www/mysql_server/mysql.sock \
-DMYSQLX_TCP_PORT=33060 \
-DMYSQLX_UNIX_ADDR=/var/www/mysql_server/mysqlx.sock \
-DDEB_ID="${CMAKE_DEB_ID}" \
-DDEB_CODENAME="${CMAKE_DEB_CODENAME}" \
-DDEB_RELEASE="${CMAKE_DEB_RELEASE}" \
-DWITH_SYSTEM_LIBS=0 \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=/usr/local/boostcxx \
-DWITH_CURL=system \
-DWITH_SSL=system \
-DCURL_ZSTD=1 \
-DWITH_FIDO=system \
-DWITH_EDITLINE=bundled \
-DWITH_ICU=bundled \
-DWITH_LIBEVENT=bundled \
-DWITH_LZ4=bundled \
-DWITH_LZMA=bundled \
-DWITH_RE2=bundled \
-DWITH_ZLIB=bundled \
-DWITH_ZSTD=bundled \
-DWITH_RAPIDJSON=bundled \
-DWITH_PROTOBUF=bundled \
-DWITH_DEBUG=0 \
-DWITH_UNIT_TESTS=0 \
\
\
&& make -j$(nproc --all) \
&& sleep 3s \
&& make install \
\
&& cd /usr/local/src \
&& rm -f       /var/www/mysql_server/sysconfdir/my.cnf \
&& cp ./my.cnf /var/www/mysql_server/sysconfdir/my.cnf \
&& chown -R www-data:www-data /var/www \
&& chown -R www-data:www-data /usr/local/mysql \
&& /usr/local/mysql/bin/mysqld --defaults-file=/var/www/mysql_server/sysconfdir/my.cnf --initialize-insecure --user=www-data \
\
&& chown -R www-data:www-data /usr/local/mysql \
&& chown -R www-data:www-data /var/www \
&& /usr/local/mysql/support-files/mysql.server start \
&& sleep 3s \
&& /usr/local/mysql/bin/mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root12345';" \
&& sleep 3s \
&& /usr/local/mysql/support-files/mysql.server restart \
&& sleep 3s \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "UPDATE mysql.user SET Host='%' WHERE User='root' AND Host='localhost';" \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "UPDATE mysql.db   SET Host='%' WHERE User='root' AND Host='localhost';" \
&& /usr/local/mysql/support-files/mysql.server restart \
&& sleep 3s \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "CREATE DATABASE test0db;" \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "CREATE DATABASE test1db;" \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "CREATE DATABASE test2db;" \
&& sleep 3s \
&& /usr/local/mysql/support-files/mysql.server stop \
\
\
&& cd /usr/local/src/php-${PHP_VERSION} \
&& ./buildconf \
&& ./configure --help \
&& ./configure --prefix=/usr/local/php \
--enable-fpm \
--with-fpm-user=www-data \
--with-fpm-group=www-data \
\
\
--enable-opcache \
--enable-ipv6 \
--enable-ctype \
--enable-dom \
--enable-fileinfo \
--enable-filter \
--enable-mbregex \
--enable-huge-code-pages \
--enable-opcache-jit \
--enable-pdo \
--enable-phar \
--enable-posix \
--enable-session \
--enable-simplexml \
--enable-tokenizer \
--enable-xml \
--with-expat \
--enable-xmlreader \
--enable-xmlwriter \
\
\
--enable-phpdbg \
--disable-short-tags \
--with-openssl \
--with-ftp-ssl \
--with-zlib \
--enable-bcmath \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif \
--enable-gd \
--with-freetype \
--with-avif \
--with-webp \
--with-jpeg \
--with-xpm \
--enable-gd-jis-conv \
--with-gettext \
--with-gmp \
--enable-intl \
--enable-mbstring \
--enable-mysqlnd \
--with-mysqlnd-ssl \
--enable-pdo \
--with-mysqli \
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
--with-xsl \
--with-tidy \
--with-sodium \
--with-password-argon2 \
--enable-ftp \
--with-capstone \
--with-pear \
--with-pdo-pgsql \
--enable-zend-max-execution-timers \
\
&& make -j$(nproc --all) \
&& sleep 3s \
&& make install \
\
&& cd /usr/local/src \
&& tree /usr/local/php \
&& rm -f /usr/local/php/etc/php-fpm.conf \
&& rm -f /usr/local/php/etc/php-fpm.d/www.conf \
&& rm -f /usr/local/php/lib/php.ini \
\
&& mv ./php-fpm.conf /usr/local/php/etc/php-fpm.conf \
&& mv ./www.conf     /usr/local/php/etc/php-fpm.d/www.conf \
&& mv ./php.ini      /usr/local/php/lib/php.ini \
\
&& mkdir -p /usr/local/php/fpm_pools/www/log \
\
&& chown -R www-data:www-data /usr/local/php \
\
&& /usr/local/php/bin/php -v \
&& /usr/local/php/bin/php -m \
&& /usr/local/php/sbin/php-fpm \
&& sleep  3s \
&& kill -INT `cat /usr/local/php/var/run/php-fpm.pid` \
\
&& echo 'export PATH="$PATH:/usr/local/php/bin:/usr/local/php/sbin"' >> ~/.bashrc \
&& export PATH="$PATH:/usr/local/php/bin:/usr/local/php/sbin" \
\
&& /usr/local/php/bin/pecl install memcached-3.3.0 \
\
&& cd /usr/local/src/phpy \
&& /usr/local/php/bin/phpize \
&& ./configure --with-python-config=python3.12-config \
&& make \
&& make install \
\
&& /usr/local/php/bin/php /usr/local/src/install.php \
\
&& cd /usr/local/src/openresty-${OPENRESTY_VERSION} \
&& ./configure --help \
&& ./configure --prefix=/usr/local/openresty \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_v3_module \
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
--with-http_iconv_module \
--without-mail_pop3_module \
--without-mail_imap_module \
--without-mail_smtp_module \
--with-stream \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_ssl_preread_module \
--with-pcre \
--with-pcre-jit \
--with-http_geoip_module=dynamic \
--with-stream_geoip_module=dynamic \
--with-http_xslt_module=dynamic \
--add-dynamic-module=/usr/local/src/nginx-module-vts \
--add-dynamic-module=/usr/local/src/nginx-http-flv-module \
--add-dynamic-module=/usr/local/src/ngx_http_geoip2_module \
--add-dynamic-module=/usr/local/src/mod_zip \
\
&& gmake -j$(nproc --all) \
&& sleep  3s \
&& gmake install \
\
&& cd /usr/local/src \
&& rm -f                /usr/local/openresty/nginx/conf/nginx.conf \
&& mv ./openresty.conf  /usr/local/openresty/nginx/conf/nginx.conf \
\
\
&& mkdir -p                    /repos/php-crud-api \
&& cp ./php-crud-api.php       /repos/php-crud-api/index.php \
&& chown -R www-data:www-data  /var/www \
\
\
&& /usr/local/openresty/nginx/sbin/nginx -t \
&& /usr/local/openresty/nginx/sbin/nginx \
&& sleep 3s \
&& /usr/local/openresty/nginx/sbin/nginx -s stop \
\
&& echo 'export PATH="$PATH:/usr/local/openresty/nginx/sbin"' >> ~/.bashrc \
&& echo 'export PATH="$PATH:/usr/local/mysql/bin"' >> ~/.bashrc \
&& echo '' >> ~/.bashrc \
\
&& apt -y autoremove \
&& apt -y clean \
&& rm -rf /var/lib/apt/lists/* \
\
&& rm -rf  /var/cache/apt/archives/*.deb \
&& rm -rf  /usr/share/doc/* \
&& rm -rf  /usr/share/man/* \
&& rm -rf  ~/.cache/* \
\
&& rm -rf /tmp/* \
&& rm -rf /var/tmp/* \
&& rm -rf /usr/local/mysql/mysql-test/* \
&& du -h --max-depth=2 /usr/local/mysql \
&& du -h --max-depth=2 /usr/local/php \
&& du -h --max-depth=2 /usr/local/openresty \
&& du -h --max-depth=3 /var/www \
&& rm -rf /usr/local/src/*

EXPOSE 80 443 3306

CMD ["/sbin/my_init"]

# source ~/.bashrc

