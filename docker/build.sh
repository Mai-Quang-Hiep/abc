#!/bin/bash

chmod -R 777  /var/www/html/storage/logs/laravel.log

echo "Starting app..."

if [[ -d "./vendor" ]]
then
    php artisan config:clear
else
    cp .env.example .env
    php artisan config:clear
    composer update
    php artisan key:generate
fi

/usr/sbin/apache2ctl -D FOREGROUND
