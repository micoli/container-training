SHELL:=/bin/bash
.SILENT:
.PHONY: help

help:
	@echo "Usage:"
	@echo "     make [command]"
	@echo
	@echo "Available commands:"
	@grep '^[^#[:space:]].*:' Makefile | grep -vE '^(default|all|help|doc)' | grep -v '^\.' | grep -v '=' | grep -v '^_' | sed 's/://' | xargs -n 1 echo ' -'

all:
	clear
	@for command in $$(grep '^[^#[:space:]].*:' Makefile | grep -vE '^(default|all|help|doc)' | grep -v '^\.' | grep -v '=' | grep -v '^_' | sed 's/://') ; do\
		echo -e "\x1b[31m$$command\x1b[0m" ;\
		$(MAKE) $$command ;\
		echo ----------------------- ;\
	done

doc:
	@lastTitle='';\
	echo "#" $$(git symbolic-ref --short HEAD | xargs | awk '{ print toupper( substr( $$0, 1, 1 ) ) substr( $$0, 2 ); }' ) ;\
	echo "" ;\
	for command in $$(grep '^[^#[:space:]].*:' Makefile | grep -vE '^(default|all|help|doc)' | grep -v '^\.' | grep -v '=' | grep -v '^_' | sed 's/://') ; do\
		title=$$(echo $$command | sed 's/-/ /g' );\
		h1=$$(echo $$title| sed -E 's/([0-9]{2})(.+)([0-9]{2})(.+)/\2/' | xargs | awk '{ print toupper( substr( $$0, 1, 1 ) ) substr( $$0, 2 ); }'  ) ;\
		h2=$$(echo $$title| sed -E 's/([0-9]{2})(.+)([0-9]{2})(.+)/\4/' | xargs | awk '{ print toupper( substr( $$0, 1, 1 ) ) substr( $$0, 2 ); }' ) ;\
		if [ "$$lastTitle" 	!= "$$h1" ]; then echo -e "## $${h1}\n" && lastTitle="$$h1" ;fi;\
		echo -e "### $${h2}\n";\
		echo -e "\`$$ make $$command\`" ; \
		code=$$($(MAKE) -n $$command) ; \
		echo -e "\n\`\`\`\n$$code\n\`\`\` \n" ; \
	done

00-status-01-view-running-containers:
	docker ps --format "{{.Names}}"
	docker ps --format "{{json .}}"
	docker ps --format "{{.ID}};{{.Image}};{{.Names}}"
	#https://docs.docker.com/config/formatting/

01-basic-php-01-run-image-and-exec:
	docker run php:7.3.2-cli-stretch php -r "print 12*12;"
	#docker run -it php:7.3.2-cli-stretch bash

02-mysql-01-cleanup:
	-docker stop mysql8
	-docker rm mysql8

02-mysql-02-run-mysql-server:
	docker run \
	  --name mysql8 \
	  --detach \
	  -p 13306:3306 \
	  --env MYSQL_ROOT_PASSWORD=azerty \
	  mysql:8.0.15
	sleep 20

02-mysql-03-execute-a-basic-query:
	docker exec  mysql8 mysql -u root --password=azerty -e 'SELECT Host,User FROM mysql.user;'

02-mysql-04-create-table-and-insert-datas:
	docker exec mysql8 mysql -u root --password=azerty -e 'DROP DATABASE IF EXISTS foo;\
	CREATE DATABASE foo;\
	USE foo;\
	DROP TABLE IF EXISTS bar;\
	CREATE TABLE bar (\
	   col01 VARCHAR(20)\
	);\
	INSERT INTO foo.bar VALUES ("azerty");'

02-mysql-05-stop-mysql-container:
	docker stop mysql8

02-mysql-06-view-running-containers:
	docker ps

02-mysql-07-view-all-containers:
	docker ps -a

02-mysql-08-restart-container-and-check:
	docker restart mysql8
	sleep 5
	docker exec mysql8 mysql -u root --password=azerty -e 'select * from foo.bar;'

02-mysql-09-cleanup:
	docker kill mysql8
	docker rm mysql8




