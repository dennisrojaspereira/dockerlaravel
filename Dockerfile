FROM php:7.3.14-fpm-alpine3.11
RUN apk add --no-cache openssl bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql
RUN apk add --no-cache git

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# COPY . /var/www
# RUN composer install && \
#      cp .env.example .env && \
#      php artisan key:generate && \
#      php artisan config:cache 

COPY ./.docker/ /var/www/.docker
# RUN ls -s public html

EXPOSE 9000

# ENTRYPOINT ["php-fpm"]