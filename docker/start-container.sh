#!/usr/bin/env bash
set -euo pipefail

# Ensure runtime directories exist
mkdir -p /run/php

chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

if [ ! -L /var/www/html/public/storage ]; then
    php artisan storage:link --ansi || true
fi

for dir in /var/www/html/config /var/www/html/public /var/www/html/lang; do
    if [ -d "$dir" ]; then
        chown -R www-data:www-data "$dir"
        chmod -R 775 "$dir"
    fi
done

php-fpm --daemonize

exec nginx -g "daemon off;"
