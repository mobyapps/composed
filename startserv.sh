#!/bin/bash

set -eux

chown -R user7:group7    /usr/local/php
chown -R user7:group7    /usr/local/openresty

/usr/local/php/sbin/php-fpm
/usr/local/openresty/nginx/sbin/nginx

chown -R user7:group7    /usr/local/php
chown -R user7:group7    /usr/local/openresty
