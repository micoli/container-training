# 02-Containers

## Status

### View running containers

`$ make 00-status-01-view-running-containers`

```
docker ps --format "{{.Names}}"
docker ps --format "{{json .}}"
docker ps --format "{{.ID}};{{.Image}};{{.Names}}"
#https://docs.docker.com/config/formatting/
``` 

## Basic php

### Run image and exec

`$ make 01-basic-php-01-run-image-and-exec`

```
docker run php:7.3.2-cli-stretch php -r "print 12*12;"
#docker run -it php:7.3.2-cli-stretch bash
``` 

## Mysql

### Cleanup

`$ make 02-mysql-01-cleanup`

```
docker stop mysql8
docker rm mysql8
``` 

### Run mysql server

`$ make 02-mysql-02-run-mysql-server`

```
docker run \
	  --name mysql8 \
	  --detach \
	  -p 13306:3306 \
	  --env MYSQL_ROOT_PASSWORD=azerty \
	  mysql:8.0.15
sleep 20
``` 

### Execute a basic query

`$ make 02-mysql-03-execute-a-basic-query`

```
docker exec  mysql8 mysql -u root --password=azerty -e 'SELECT Host,User FROM mysql.user;'
``` 

### Create table and insert datas

`$ make 02-mysql-04-create-table-and-insert-datas`

```
docker exec mysql8 mysql -u root --password=azerty -e 'DROP DATABASE IF EXISTS foo;\
	CREATE DATABASE foo;\
	USE foo;\
	DROP TABLE IF EXISTS bar;\
	CREATE TABLE bar (\
	   col01 VARCHAR(20)\
	);\
	INSERT INTO foo.bar VALUES ("azerty");'
``` 

### Stop mysql container

`$ make 02-mysql-05-stop-mysql-container`

```
docker stop mysql8
``` 

### View running containers

`$ make 02-mysql-06-view-running-containers`

```
docker ps
``` 

### View all containers

`$ make 02-mysql-07-view-all-containers`

```
docker ps -a
``` 

### Restart container and check

`$ make 02-mysql-08-restart-container-and-check`

```
docker restart mysql8
sleep 5
docker exec mysql8 mysql -u root --password=azerty -e 'select * from foo.bar;'
``` 

### Cleanup

`$ make 02-mysql-09-cleanup`

```
docker kill mysql8
docker rm mysql8
``` 

