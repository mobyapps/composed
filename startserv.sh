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
