FROM yarnpkg/node-yarn as yarn
RUN npm install -g less

COPY styles/* ./

RUN lessc main.less main.css

FROM phpearth/php:7.3-nginx

RUN apk add composer;\
    mkdir -p /var/log; \
    mkdir /application; \
    apk add make;\
    mkdir var; \
    chmod 777 var;

ARG APP_ENV
ENV APP_ENV=$APP_ENV

WORKDIR /application

COPY composer.* ./
COPY symfony.lock ./
RUN composer install --no-dev --no-scripts

COPY .docker /

COPY bin bin
COPY config config
COPY public public
COPY src src
COPY templates templates
COPY tests tests

COPY Makefile ./
COPY phpunit.xml.dist ./
COPY .php_cs.dist ./
COPY .env.dist ./.env
COPY --from=yarn main.css public/

RUN composer dump-autoload; \
    bin/console cache:warmup;
