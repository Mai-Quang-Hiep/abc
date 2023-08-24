# Sử dụng hình ảnh chứa PHP và Apache
FROM php:8.1-apache

# Cài đặt các phụ thuộc của Laravel
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip

# Cài đặt composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Cài đặt và cấu hình phần mềm PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Đặt thư mục làm việc
WORKDIR /var/www/html/

# Sao chép mã nguồn Laravel vào hình ảnh
COPY . .

# Cài đặt các gói PHP qua Composer
RUN composer install

# Cấu hình permisssions
RUN chmod 777 /var/www/html/storage /var/www/html/bootstrap/cache

# Mở cổng cho Apache
EXPOSE 80
COPY ./docker/build.sh /build.sh
COPY ./docker/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./docker/php.ini /etc/php/8.1/apache2/php.ini
RUN a2enmod rewrite

ENTRYPOINT ["/build.sh"]

