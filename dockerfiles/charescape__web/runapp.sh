#!/bin/bash

set -eux


# find /var/www -not \( -path "*/node_modules/*" -o -path "*/\.git/*" \) -exec chown www-data:www-data {} \;

chown -R www-data:www-data /var/www/
chown -R www-data:www-data /usr/local/mysql/
chown -R www-data:www-data /usr/local/php/
chown -R www-data:www-data /usr/local/openresty/

/usr/local/mysql/support-files/mysql.server start

/usr/local/php/bin/php -v
/usr/local/php/sbin/php-fpm

/usr/local/openresty/nginx/sbin/nginx -t
/usr/local/openresty/nginx/sbin/nginx

pgrep -l mysql
pgrep -l php
pgrep -l nginx
