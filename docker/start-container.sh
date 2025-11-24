#!/usr/bin/env bash
set -euo pipefail

# Ensure runtime directories exist
mkdir -p /run/php

chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

if [ ! -L /var/www/html/public/storage ]; then
    php artisan storage:link --ansi || true
fi

php-fpm --daemonize

exec nginx -g "daemon off;"
