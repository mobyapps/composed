#!/bin/bash

set -eux

# for php
chown -R user7:group7    /usr/local/php

/usr/local/php/bin/php -v
/usr/local/php/sbin/php-fpm

chown -R user7:group7    /usr/local/php


# for nginx
chown -R user7:group7    /usr/local/nginx

/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx

chown -R user7:group7    /usr/local/nginx


# for memcached
chown -R user7:group7    /usr/local/memcached

/usr/local/memcached/bin/memcached --user=root \
--port=11211 \
--memory-limit=128 \
--conn-limit=1024 \
--threads=4 \
--pidfile=/tmp/memcached.pid \
--daemon

chown -R user7:group7    /usr/local/memcached
