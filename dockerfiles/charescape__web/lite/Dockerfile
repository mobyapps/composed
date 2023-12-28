FROM phusion/baseimage:jammy-1.0.1

LABEL maintainer="charescape@outlook.com"

ENV TZ                  Asia/Shanghai

ENV PHP_VERSION         8.2.14
ENV PHP_HASH            4c1fbb55a10ece7f4532feba9f3f88b9b211c11320742977588738374c03255f

ENV COMPOSER_VERSION    2.6.6
ENV COMPOSER_HASH       72600201c73c7c4b218f1c0511b36d8537963e36aafa244757f52309f885b314

ENV OPENRESTY_VERSION   1.21.4.3
ENV OPENRESTY_HASH      33a84c63cfd9e46b0e5c62eb2ddc7b8068bda2e1686314343b89fc3ffd24cdd3

COPY ./dockerfiles/charescape__web/lite/runapps.sh  /etc/my_init.d/

ADD https://raw.githubusercontent.com/mobyapps/composed/ubuntu22-php82-mysql80/configfiles/php.ini                 /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/ubuntu22-php82-mysql80/configfiles/php-fpm.conf            /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/ubuntu22-php82-mysql80/configfiles/www.conf                /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/ubuntu22-php82-mysql80/configfiles/openresty_testing.conf  /usr/local/src/
ADD https://raw.githubusercontent.com/mobyapps/composed/ubuntu22-php82-mysql80/ttt/dbapi.php                       /usr/local/src/

# see http://www.ruanyifeng.com/blog/2017/11/bash-set.html
RUN set -eux \
&& export DEBIAN_FRONTEND=noninteractive \
&& export CPUS_COUNT=`cat /proc/cpuinfo | grep processor | wc -l` \
\
&& date -d "1 day ago" \
&& echo "${TZ}" > /etc/timezone \
&& ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
&& cat /etc/timezone \
\
&& apt -y update            \
&& apt -y upgrade           \
&& apt -y autoremove           \
&& apt -y install --fix-broken  \
&& apt -y install --fix-missing \
\
&& echo '' >> ~/.bashrc         \
\
&& apt -y install sudo tzdata build-essential \
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
p7zip-full                      \
socat                           \
zstd                            \
libtool                         \
imagemagick                     \
wkhtmltopdf                     \
supervisor                      \
libxml2-dev                     \
libssl-dev                      \
libcurl4-openssl-dev            \
libsqlite3-dev                  \
libbz2-dev                      \
libgmp-dev                      \
libonig-dev                     \
libreadline-dev                 \
libsodium-dev                   \
libargon2-dev                   \
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
libevent-dev                    \
liblz4-dev                      \
libsasl2-dev                    \
libldap2-dev                    \
libavif-dev                     \
\
\
libvulkan1                      \
\
\
nodejs \
npm \
chromium-chromedriver \
firefox \
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
libu2f-udev \
\
fontconfig \
fonts-noto-color-emoji \
fonts-arphic-bkai00mp \
fonts-arphic-bsmi00lp \
fonts-arphic-gbsn00lp \
fonts-arphic-gkai00mp \
fonts-arphic-ukai \
fonts-arphic-uming \
fonts-wqy-zenhei \
fonts-wqy-microhei \
xfonts-wqy \
\
fonts-liberation \
libappindicator3-1 \
xdg-utils \
mplayer \
\
\
&& date -d "1 day ago" \
&& ls -l /usr/share/zoneinfo/ \
&& ls -l /usr/share/zoneinfo/Asia/ \
\
\
&& chmod +x /etc/my_init.d/runapps.sh \
\
\
&& cd /usr/local/bin/ \
&& wget https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar \
&& echo "${COMPOSER_HASH} *composer.phar" | shasum -a 256 --check \
&& COMPOSER_HASH_CHECK=$? \
&& if [ "$COMPOSER_HASH_CHECK" -ne "0" ]; then echo "composer.phar hash mismatch." && exit 1; fi \
\
&& mv /usr/local/bin/composer.phar /usr/local/bin/composer \
&& chmod +x /usr/local/bin/composer \
&& chown www-data:www-data /usr/local/bin/composer \
\
&& cd /usr/local \
&& wget https://curl.se/ca/cacert.pem \
&& wget https://curl.se/ca/cacert.pem.sha256 \
&& cat cacert.pem.sha256 | shasum -a 256 --check \
&& CACERT_HASH_CHECK=$? \
&& if [ "$CACERT_HASH_CHECK" -ne "0" ]; then echo "cacert.pem hash mismatch." && exit 1; fi \
&& rm cacert.pem.sha256 \
\
&& chown www-data:www-data /usr/local/cacert.pem \
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
&& git clone --recurse-submodules -j8 https://github.com/google/ngx_brotli --verbose \
\
&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& dpkg -i google-chrome-stable_current_amd64.deb \
&& apt     install -y --fix-broken \
&& apt     install -y --fix-missing \
\
&& tar -zxf php-${PHP_VERSION}.tar.gz \
&& tar -zxf openresty-${OPENRESTY_VERSION}.tar.gz \
\
\
&& mkdir -p /var/www/ip_site \
&& mkdir -p /var/www/runlogs \
&& chown -R www-data:www-data /var/www \
\
\
&& cd /usr/local/src/php-${PHP_VERSION} \
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
--enable-xmlreader \
--enable-xmlwriter \
\
\
--enable-phpdbg \
--disable-short-tags \
--with-openssl \
--with-openssl-dir \
--with-zlib \
--with-zlib-dir \
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
--with-mhash \
--enable-intl \
--enable-mbstring \
--enable-mysqlnd \
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
\
&& make -j$CPUS_COUNT \
&& sleep 3s \
&& make install \
\
&& cd /usr/local/src \
&& rm -f /usr/local/php/etc/php-fpm.conf \
&& rm -f /usr/local/php/etc/php-fpm.d/www.conf \
&& rm -f /usr/local/php/lib/php.ini \
\
&& mv ./php-fpm.conf /usr/local/php/etc/php-fpm.conf \
&& mv ./www.conf     /usr/local/php/etc/php-fpm.d/www.conf \
&& mv ./php.ini      /usr/local/php/lib/php.ini \
\
&& chown -R www-data:www-data /usr/local/php \
\
&& /usr/local/php/bin/php -v \
&& sleep  3s \
&& /usr/local/php/sbin/php-fpm \
&& sleep  3s \
&& kill -INT `cat /usr/local/php/var/run/php-fpm.pid` \
\
&& cd /usr/local/src \
\
&& cd /usr/local/src/ngx_brotli/deps/brotli \
&& mkdir out \
&& cd out \
&& cmake -DCMAKE_BUILD_TYPE=Release \
-DBUILD_SHARED_LIBS=OFF \
-DCMAKE_C_FLAGS="-Ofast -m64 -march=native -mtune=native -flto -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections" \
-DCMAKE_CXX_FLAGS="-Ofast -m64 -march=native -mtune=native -flto -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections" \
-DCMAKE_INSTALL_PREFIX=./installed .. \
\
&& cmake --build . --config Release --target brotlienc \
\
&& cd /usr/local/src/openresty-${OPENRESTY_VERSION} \
&& ./configure --help \
&& export CFLAGS="-m64 -march=native -mtune=native -Ofast -flto -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections" \
&& export LDFLAGS="-m64 -Wl,-s -Wl,-Bsymbolic -Wl,--gc-sections" \
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
--add-module=/usr/local/src/ngx_brotli \
\
&& gmake -j$CPUS_COUNT \
&& sleep  3s \
&& gmake install \
\
&& cd /usr/local/src \
&& rm -f                        /usr/local/openresty/nginx/conf/nginx.conf \
&& mv ./openresty_testing.conf  /usr/local/openresty/nginx/conf/nginx.conf \
\
\
&& mkdir                       /repos \
&& mkdir -p                    /repos/ttt/dbapi \
&& cp ./dbapi.php              /repos/ttt/dbapi/index.php \
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
&& echo '' >> ~/.bashrc \
\
&& apt -y autoremove \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /tmp/* \
&& rm -rf /var/tmp/* \
&& du -h --max-depth=2 /usr/local/php \
&& du -h --max-depth=2 /usr/local/openresty \
&& du -h --max-depth=3 /var/www \
&& rm -rf /usr/local/src/*

EXPOSE 80 443

CMD ["/sbin/my_init"]

# source ~/.bashrc
