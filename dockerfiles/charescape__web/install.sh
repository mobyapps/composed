
# yum update

groupadd w3web
useradd -s /sbin/nologin -g w3web w3web
mkdir /var/w3web

yum install perl-Digest-SHA

echo "0055f368ffefe51d5a4483755bd17475e88e74302c08b727952831c5b2682ea2 *php-7.1.33.tar.gz" | shasum -a 256 --check
echo "4c373e7ab5bf91d34a4f11a0c9496561061ba5eee6020db272a17a7228d35f99 *nginx-1.18.0.tar.gz" | shasum -a 256 --check
echo "47f11c8844e579d02691a607fbd32540104a9ac7a2534a8ddaef50daf502baac *boost_1_59_0.tar.gz" | shasum -a 256 --check
echo "aab940cd53d285a54c50465820a2080fcb7182a4ba1e5f795abfb10414a4b4be *composer.phar" | shasum -a 256 --check
echo "d0b73805a99c867f7cda0b9cec6ad720 *mysql-5.7.30.tar.gz" | md5sum --check
cat cacert.pem.sha256 | shasum -a 256 --check

https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.30.tar.gz
https://nginx.org/download/nginx-1.18.0.tar.gz
https://www.php.net/distributions/php-7.1.33.tar.gz
https://zenlayer.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz?viasf=1

tar -zxf php-7.1.33.tar.gz
tar -zxf nginx-1.18.0.tar.gz
tar -zxf mysql-5.7.30.tar.gz

yum groupinstall "Development Tools"
yum install cmake \
            autoconf \
            pkg-config \
            re2c                            \
            bison                           \
            zip                             \
            socat                           \
            zstd                            \
            libtool \
            libxml2-devel \
            openssl-devel \
            bzip2-devel \
            libcurl-devel \
            gmp-devel \
            libicu-devel \
            readline-devel \
            libtidy-devel \
            libxslt-devel \
            \
            pcre-devel \
            geoip-devel \
            \
            jemalloc \
            libtirpc-devel \
            rpcgen \


./configure --prefix=/usr/local/php \
--enable-fpm \
--with-fpm-user=w3web \
--with-fpm-group=w3web \
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
--with-pear


cd /usr/local/nginx
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
--with-stream \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_ssl_preread_module \
--with-pcre-jit \
--with-http_geoip_module=dynamic \
--with-stream_geoip_module=dynamic \
--with-http_xslt_module=dynamic


mkdir /usr/local/src/mysql-5.7.30/build_tmp_dir
mkdir /var/w3web/mysql_data
mkdir /var/w3web/mysql_conf
mkdir /var/w3web/mysql_temp
chown -R w3web:w3web /var/w3web

# 如果内存不足：https://blog.csdn.net/m0_37844878/article/details/73497892

cmake .. -LH -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DCMAKE_BUILD_TYPE=Release \
-DWITH_SYSTEM_LIBS=1 \
-DMYSQL_DATADIR=/var/w3web/mysql_data \
-DSYSCONFDIR=/var/w3web/mysql_conf \
-DTMPDIR=/var/w3web/mysql_temp \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_unicode_ci \
-DDOWNLOAD_BOOST=0 \
-DWITH_BOOST=/usr/local/src/boost_1_59_0 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_TCP_PORT=3306 \
-DMYSQL_UNIX_ADDR=/var/w3web/mysql.sock \
-DWITH_JEMALLOC=1 \
-DWITH_RAPIDJSON=bundled \
-DWITH_PROTOBUF=bundled \
-DWITH_FIDO=bundled \
-DWITH_UNIT_TESTS=0


chown -R w3web:w3web /usr/local/php
chown -R w3web:w3web /usr/local/nginx
chown -R w3web:w3web /usr/local/mysql
chown -R w3web:w3web /var/w3web
