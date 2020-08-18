#!/bin/bash

set -eux

/usr/local/php/bin/php -v
/usr/local/php/sbin/php-fpm --allow-to-run-as-root

/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx
