mkdir -p /var/www \
&& mkdir /var/www/mariadb_server \
&& mkdir /var/www/mariadb_server/datadir \
&& mkdir /var/www/mariadb_server/sysconfdir \
&& mkdir /var/www/mariadb_server/tmpdir \
&& mkdir /var/www/mariadb_server/tmprundatadir \

apt -y install \
liblzo2-dev \
libsnappy-dev \
\
&& mkdir /usr/local/src/mariadb-${MARIADB_VERSION}/build_tmp_dir \
&& cd /usr/local/src/mariadb-${MARIADB_VERSION}/build_tmp_dir \
&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/mariadb \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DDISABLE_SHARED=1 \
-DMYSQL_DATADIR=/var/www/mariadb_server/datadir \
-DSYSCONFDIR=/var/www/mariadb_server/sysconfdir \
-DTMPDIR=/var/www/mariadb_server/tmpdir \
-DINSTALL_RUNDATADIR=/var/www/mariadb_server/tmprundatadir \
-DWITH_SYSTEM_LIBS=0 \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_0900_ai_ci \
-DWITH_EXTRA_CHARSETS=all \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_TCP_PORT=3307 \
-DMYSQL_UNIX_ADDR=/var/www/mariadb_server/mariadb.sock \
-DMYSQLX_TCP_PORT=33070 \
-DMYSQLX_UNIX_ADDR=/var/www/mariadb_server/mariadbx.sock \
-DWITH_LIBAIO=1 \
-DWITH_ROCKSDB_ZSTD=ON \
-DWITH_SYSTEMD=no \
-DDEB_ID="Ubuntu" \
-DDEB_CODENAME="noble" \
-DDEB_RELEASE="24.04" \
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
-DWITH_UNIT_TESTS=0
