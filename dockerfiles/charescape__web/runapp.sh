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

if [ -e /var/www/nginx.conf ]
then
  /usr/local/openresty/nginx/sbin/nginx -c /var/www/nginx.conf -t
  /usr/local/openresty/nginx/sbin/nginx -c /var/www/nginx.conf
else
  /usr/local/openresty/nginx/sbin/nginx -t
  /usr/local/openresty/nginx/sbin/nginx
fi

pgrep -l mysql
pgrep -l php
pgrep -l nginx
