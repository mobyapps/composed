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
-DCMAKE_BUILD_TYPE=Release \
-DDISABLE_SHARED=1 \
-DMYSQL_DATADIR=/var/www/mariadb_server/datadir \
-DSYSCONFDIR=/var/www/mariadb_server/sysconfdir \
-DTMPDIR=/var/www/mariadb_server/tmpdir \
-DINSTALL_RUNDATADIR=/var/www/mariadb_server/tmprundatadir \
-DWITH_SYSTEM_LIBS=1 \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_0900_ai_ci \
-DWITH_EXTRA_CHARSETS=all \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_TCP_PORT=3307 \
-DMYSQL_UNIX_ADDR=/var/www/mariadb.sock \
-DWITH_LIBAIO=1 \
-DWITH_RAPIDJSON=bundled \
-DWITH_PROTOBUF=bundled \
-DWITH_FIDO=bundled \
-DWITH_ROCKSDB_ZSTD=ON \
-DWITH_SYSTEMD=no \
-DWITH_UNIT_TESTS=0
