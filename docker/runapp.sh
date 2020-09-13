#!/bin/bash

set -eux

chown -R www-data:www-data /var/www
chown -R www-data:www-data /usr/local/mysql
chown -R www-data:www-data /usr/local/php
chown -R www-data:www-data /usr/local/nginx

/usr/local/mysql/support-files/mysql.server start

/usr/local/php/bin/php -v
/usr/local/php/sbin/php-fpm

/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx
