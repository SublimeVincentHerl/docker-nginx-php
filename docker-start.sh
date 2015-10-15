#!/bin/bash
set -e
service nginx start &
service php5-fpm restart
tail -f /var/log/nginx/access.log &
tail -f /var/log/nginx/error.log
