FROM php:7.1

RUN apt-get update && apt-get install -y  libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        git \
        zip \
        && docker-php-ext-install zip \
        && docker-php-ext-install pdo bcmath \
        && docker-php-ext-install -j$(nproc) iconv mcrypt \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd
# Install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN apt-get install -y libssl-dev
#PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


#COPY . /var/www/html
WORKDIR /var/www/html
