FROM php:8.2.9-apache

# add group and user : fpm
RUN groupadd --system -g 1000 obydul
RUN useradd -d /home/obydul -s /bin/sh -u 1001 -g 1000 obydul

# config
ADD /.docker/php.ini /usr/local/etc/php/php.ini

# upload app to server
ADD ./app /var/www/html

# set permissioms
RUN mkdir -p /var/www/html/uploads
RUN chown obydul:obydul -R /var/www/html/
RUN chown www-data:www-data -R /var/www/html/uploads/