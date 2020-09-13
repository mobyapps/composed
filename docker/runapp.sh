#!/bin/bash

set -eux

/usr/local/mysql/support-files/mysql.server status
/usr/local/mysql/support-files/mysql.server start

/usr/local/php/bin/php -v
/usr/local/php/sbin/php-fpm

/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx
