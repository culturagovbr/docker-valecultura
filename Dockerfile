FROM php:5.6.30-apache

VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]

RUN echo "[ ***** ***** ***** ] - Copying files to Image ***** ***** ***** "
COPY ./src /tmp/src

RUN apt-get update

RUN echo "[ ***** ***** ***** ] - Installing each item in new command to use cache and avoid download again ***** ***** ***** "
RUN apt-get install -y apt-utils libfreetype6-dev libjpeg62-turbo-dev libcurl4-gnutls-dev libxml2-dev freetds-dev git

RUN echo "[ ***** ***** ***** ] - Installing PHP Dependencies ***** ***** ***** "
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-configure mssql --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install mssql
RUN docker-php-ext-configure pdo_dblib --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install pdo_dblib

RUN chmod +x -R /tmp/src/

EXPOSE 80

WORKDIR /var/www/

RUN echo "[ ***** ***** ***** ] - Begin of Actions inside Image ***** ***** ***** "
CMD /tmp/src/actions/start.sh
