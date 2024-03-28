# FROM php:8.0
# RUN apt-get update -y && apt-get install -y openssl zip unzip git
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN docker-php-ext-install pdo mbstring
# WORKDIR /app
# COPY . /app
# RUN composer install

# CMD php artisan serve --host=0.0.0.0 --port=8181
# EXPOSE 8181


# /33
# FROM php:8.2-apache

# WORKDIR /var/www/html

# RUN curl -o /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar \
#     && chmod +x /usr/local/bin/composer

# # hadolint ignore=DL3008
# RUN apt-get update \
#     && apt-get install --no-install-recommends -y \
#     cron \
#     icu-devtools \
#     jq \
#     libfreetype6-dev libicu-dev libjpeg62-turbo-dev libpng-dev libpq-dev \
#     libsasl2-dev libssl-dev libwebp-dev libxpm-dev libzip-dev libzstd-dev \
#     unzip \
#     zlib1g-dev \
#     && apt-get clean \
#     && apt-get autoclean \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# # hadolint ignore=DL3059
# RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
#     && pecl install --configureoptions='enable-redis-igbinary="yes" enable-redis-lzf="yes" enable-redis-zstd="yes"' igbinary zstd redis \
#     && pecl clear-cache \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm \
#     && docker-php-ext-install gd intl pdo_mysql pdo_pgsql zip \
#     && docker-php-ext-enable igbinary opcache redis zstd

# COPY composer.json composer.lock ./
# RUN composer install --no-autoloader --no-scripts --no-dev

# COPY . /var/www/html/
# RUN composer install --optimize-autoloader --no-dev

# EXPOSE 80
# CMD ["apache2-foreground"]

# //last
FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install zip \
    && a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY . /var/www/html

RUN composer install
RUN chown -R www-data:www-data /var/www/html/storage
RUN chmod -R 777 /var/www/html/storage

EXPOSE 80