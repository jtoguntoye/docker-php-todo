FROM php:7-apache
LABEL Joel joeloguntoye@gmail.com

# install , unzip extension and mysql client
RUN apt-get update --fix-missing && apt-get install -y \
    unzip \
    zip \
    curl 

# Install php dependencies for mysql
RUN docker-php-ext-install pdo_mysql mysqli

#copy over the virtualhost config file
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
COPY start-apache /usr/local/bin

RUN a2enmod rewrite

# Install php dependency - composer
RUN curl -sS https://getcomposer.org/installer |php && mv composer.phar /usr/local/bin/composer

# Copy application source files
COPY . /var/www/html


WORKDIR /var/www/html
RUN mv .env.sample .env
RUN chown -R www-data:www-data /var/www

EXPOSE 80

CMD ["start-apache"]




