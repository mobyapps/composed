FROM phusion/baseimage:focal-1.0.0-amd64

LABEL maintainer="charescape@outlook.com"

ENV MYSQL_MAIN_VERSION  8.0
ENV MYSQL_VERSION       8.0.25
ENV MYSQL_HASH          001a17602310317d17524b2e36113c53

ENV PHP_VERSION         7.4.20
ENV PHP_HASH            84b09e4617e960b36dfa15fdbf2e3cd7141a2e877216ea29391b12ae86963cf4

ENV COMPOSER_VERSION    2.1.3
ENV COMPOSER_HASH       f8a72e98dec8da736d8dac66761ca0a8fbde913753e9a43f34112367f5174d11

ENV OPENRESTY_VERSION   1.19.3.2
ENV OPENRESTY_HASH      ce40e764990fbbeb782e496eb63e214bf19b6f301a453d13f70c4f363d1e5bb9

COPY ./dockerfiles/charescape__web/runapp.sh  /etc/my_init.d/

ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/php.ini                 /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/my.cnf                  /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/php-fpm.conf            /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/www.conf                /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/configfiles/openresty_testing.conf  /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/master/ttt/ttt_dbapi.php                   /usr/local/src/

# see http://www.ruanyifeng.com/blog/2017/11/bash-set.html
RUN set -eux \
&& export DEBIAN_FRONTEND=noninteractive \
&& export CPUS_COUNT=`cat /proc/cpuinfo | grep processor | wc -l` \
\
&& apt-get -y update            \
&& apt-get -y upgrade           \
\
&& echo '' >> ~/.bashrc         \
\
&& apt-get -y install sudo build-essential \
cmake                           \
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
socat                           \
zstd                            \
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
libjemalloc-dev                 \
libzstd-dev                     \
libedit-dev                     \
libeditline-dev                 \
libevent-dev                    \
liblz4-dev                      \
libsasl2-dev                    \
libldap2-dev                    \
\
\
\
nodejs \
npm \
libgtk2.0-0 \
libgtk-3-0 \
libnotify-dev \
libgconf-2-4 \
libgbm-dev \
libnss3 \
libxss1 \
libasound2 \
libxtst6 \
xauth \
xvfb \
\
fontconfig \
fonts-noto-color-emoji \
fonts-arphic-bkai00mp \
fonts-arphic-bsmi00lp \
fonts-arphic-gbsn00lp \
fonts-arphic-gkai00mp \
fonts-arphic-ukai \
fonts-arphic-uming \
ttf-wqy-zenhei \
ttf-wqy-microhei \
xfonts-wqy \
\
fonts-liberation \
libappindicator3-1 \
xdg-utils \
mplayer \
\
\
\
&& echo '' >> /etc/hosts \
&& echo '127.0.0.1 dbapi.ttt.com' >> /etc/hosts \
&& echo '127.0.0.1 app.laraveltest.com' >> /etc/hosts \
&& echo '127.0.0.1 app.yiitest.com' >> /etc/hosts \
&& echo '127.0.0.1 app.symfonytest.com' >> /etc/hosts \
&& echo '127.0.0.1 app.slimtest.com' >> /etc/hosts \
&& echo '127.0.0.1 app.cakephptest.com' >> /etc/hosts \
&& echo '' >> /etc/hosts \
\
&& chmod +x /etc/my_init.d/runapp.sh \
\
&& cd /usr/local/bin/ \
&& wget https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar \
&& echo "${COMPOSER_HASH} *composer.phar" | shasum -a 256 --check \
&& COMPOSER_HASH_CHECK=$? \
&& if [ "$COMPOSER_HASH_CHECK" -ne "0" ]; then echo "composer.phar hash mismatch." && exit 1; fi \
\
&& chmod +x /usr/local/bin/composer.phar \
&& chown www-data:www-data /usr/local/bin/composer.phar \
\
&& cd /usr/local/src \
\
&& wget https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz \
&& echo "${PHP_HASH} *php-${PHP_VERSION}.tar.gz" | shasum -a 256 --check \
&& PHP_HASH_CHECK=$? \
&& if [ "$PHP_HASH_CHECK" -ne "0" ]; then echo "php-${PHP_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& wget https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz \
&& echo "${OPENRESTY_HASH} *openresty-${OPENRESTY_VERSION}.tar.gz" | shasum -a 256 --check \
&& OPENRESTY_HASH_CHECK=$? \
&& if [ "$OPENRESTY_HASH_CHECK" -ne "0" ]; then echo "openresty-${OPENRESTY_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& wget https://cdn.mysql.com/Downloads/MySQL-${MYSQL_MAIN_VERSION}/mysql-${MYSQL_VERSION}.tar.gz \
&& echo "${MYSQL_HASH} *mysql-${MYSQL_VERSION}.tar.gz" | md5sum --check \
&& MYSQL_HASH_CHECK=$? \
&& if [ "$MYSQL_HASH_CHECK" -ne "0" ]; then echo "mysql-${MYSQL_VERSION}.tar.gz hash mismatch." && exit 1; fi \
\
&& wget https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb \
&& dpkg -i google-chrome-unstable_current_amd64.deb \
&& apt-get install -y --fix-missing \
\
&& tar -zxf mysql-${MYSQL_VERSION}.tar.gz \
&& tar -zxf php-${PHP_VERSION}.tar.gz \
&& tar -zxf openresty-${OPENRESTY_VERSION}.tar.gz \
\
&& sed -i 's/dl.bintray.com\/boostorg\/release/boostorg.jfrog.io\/artifactory\/main\/release/' /usr/local/src/mysql-${MYSQL_VERSION}/cmake/boost.cmake \
\
&& mkdir -p /var/www/mysql_data \
&& mkdir -p /var/www/mysql_conf \
&& mkdir -p /var/www/mysql_temp \
&& mkdir -p /var/www/default_site \
&& chown -R www-data:www-data /var/www \
\
&& mkdir /usr/local/src/mysql-${MYSQL_VERSION}/build_tmp_dir \
&& cd /usr/local/src/mysql-${MYSQL_VERSION}/build_tmp_dir \
&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DCMAKE_BUILD_TYPE=Release \
-DWITH_SYSTEM_LIBS=1 \
-DMYSQL_DATADIR=/var/www/mysql_data \
-DSYSCONFDIR=/var/www/mysql_conf \
-DTMPDIR=/var/www/mysql_temp \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_unicode_ci \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=/usr/local/boostcxx \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_TCP_PORT=3306 \
-DMYSQL_UNIX_ADDR=/var/www/mysql.sock \
-DWITH_JEMALLOC=1 \
-DWITH_RAPIDJSON=bundled \
-DWITH_PROTOBUF=bundled \
-DWITH_UNIT_TESTS=0 \
\
&& make -j$CPUS_COUNT \
&& sleep 3s \
&& make install \
\
&& cd /usr/local/src \
&& cp ./my.cnf /var/www/mysql_conf/my.cnf \
&& chown -R www-data:www-data /var/www \
&& /usr/local/mysql/bin/mysqld --defaults-file=/var/www/mysql_conf/my.cnf --initialize-insecure --user=www-data \
\
&& chown -R www-data:www-data /usr/local/mysql \
&& chown -R www-data:www-data /var/www \
&& /usr/local/mysql/support-files/mysql.server start \
&& sleep 3s \
&& /usr/local/mysql/bin/mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root12345';" \
&& sleep 3s \
&& /usr/local/mysql/support-files/mysql.server restart \
&& sleep 3s \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "CREATE DATABASE testdb0;" \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "CREATE DATABASE testdb1;" \
&& /usr/local/mysql/bin/mysql -uroot -proot12345 -e "CREATE DATABASE testdb2;" \
&& sleep 3s \
&& /usr/local/mysql/support-files/mysql.server stop \
\
\
&& cd /usr/local/src/php-${PHP_VERSION} \
&& ./configure --prefix=/usr/local/php \
--enable-fpm \
--with-fpm-user=www-data \
--with-fpm-group=www-data \
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
--with-xsl \
--with-tidy \
--with-xmlrpc \
--with-iconv-dir \
--with-sodium \
--with-password-argon2 \
\
&& make -j$CPUS_COUNT \
&& sleep 3s \
&& make install \
\
&& cd /usr/local/src \
&& yes | cp ./php-fpm.conf /usr/local/php/etc/php-fpm.conf \
&& yes | cp ./www.conf     /usr/local/php/etc/php-fpm.d/www.conf \
&& yes | cp ./php.ini      /usr/local/php/lib/php.ini \
\
&& /usr/local/php/bin/php -v \
&& sleep  3s \
&& /usr/local/php/sbin/php-fpm \
&& sleep  3s \
&& kill -INT `cat /usr/local/php/var/run/php-fpm.pid` \
\
&& cd /usr/local/src \
\
&& cd /usr/local/src/openresty-${OPENRESTY_VERSION} \
&& ./configure --prefix=/usr/local/openresty \
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
--with-stream \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_ssl_preread_module \
--with-pcre-jit \
--with-http_geoip_module=dynamic \
--with-stream_geoip_module=dynamic \
--with-http_xslt_module=dynamic \
\
&& make -j$CPUS_COUNT \
&& sleep  3s \
&& make install \
\
&& cd /usr/local/src \
&& rm -f                        /usr/local/openresty/nginx/conf/nginx.conf \
&& cp ./openresty_testing.conf  /usr/local/openresty/nginx/conf/nginx.conf \
\
\
&& mkdir                       /var/www/repos \
&& mkdir -p                    /var/www/repos/ttt/dbapi \
&& cp ./ttt_dbapi.php          /var/www/repos/ttt/dbapi/index.php \
&& chown -R www-data:www-data  /var/www \
\
\
&& /usr/local/openresty/nginx/sbin/nginx -t \
&& /usr/local/openresty/nginx/sbin/nginx \
&& sleep 3s \
&& /usr/local/openresty/nginx/sbin/nginx -s stop \
\
&& echo '' >> ~/.bashrc \
&& echo 'export PATH="$PATH:/usr/local/php/bin:/usr/local/php/sbin"' >> ~/.bashrc \
&& echo 'export PATH="$PATH:/usr/local/openresty/nginx/sbin"' >> ~/.bashrc \
&& echo 'export PATH="$PATH:/usr/local/mysql/bin"' >> ~/.bashrc \
&& echo '' >> ~/.bashrc \
\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& rm -rf /usr/local/mysql/mysql-test/* \
&& rm -rf /usr/local/src/*

EXPOSE 80 443 9000 3306

CMD ["/sbin/my_init"]

# source ~/.bashrc
