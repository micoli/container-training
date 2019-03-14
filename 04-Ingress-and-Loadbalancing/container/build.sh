#!/usr/bin/env bash

cd "$(dirname "$0")"

docker build -t localhost:5000/simple-php-application:latest .
docker push localhost:5000/simple-php-application:latest
