FROM php:8.2.9-apache

# add group and user : fpm
RUN groupadd --system -g 1000 obydul
RUN useradd -d /home/obydul -s /bin/sh -u 1001 -g 1000 obydul

# config
ADD .docker/php.ini /usr/local/etc/php/php.ini

# upload app to server
ADD app /var/www/html


# install cron
RUN apt update && apt -y install cron

# file delete shell
ADD cron/shell.sh /etc/cron.d/shell.sh
RUN chmod 0644 /etc/cron.d/shell.sh

RUN touch /var/log/cron.log

# add cron jobs
# RUN echo "* * * * * root echo "Hello world" >> /var/log/cron.log 2>&1" >> /etc/crontab
RUN echo "* * * * * root sh /etc/cron.d/shell.sh > /dev/null 2>&1" >> /etc/crontab

# start cron service
RUN sed -i 's/^exec /service cron start\n\nexec /' /usr/local/bin/apache2-foreground


# set file permissioms
RUN mkdir -p /var/www/html/uploads
RUN chown obydul:obydul -R /var/www/html/
RUN chown www-data:www-data -R /var/www/html/uploads/