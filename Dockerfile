FROM phpearth/php:7.3-nginx

RUN apk add \
        bash \
        sqlite \
        php7.3-sqlite3;

WORKDIR /var/www/html/

RUN mkdir /var/www/data/; \
    chmod 777 /var/www/data/

COPY src/* ./

