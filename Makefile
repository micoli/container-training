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

00-build-01-build-image:
	docker build \
	  --tag php-registration \
	  .

00-build-02-push:
	echo "docker login"
	echo "docker tag php-registration micoli/php-registration"

00-build-03-run-web-server:
	- docker kill php-registration
	- docker rm php-registration
	docker run \
	  --name php-registration \
	  --rm \
	  --detach \
	  -v $$PWD/db:/var/www/data \
	  -p 13380:80 \
	  php-registration

00-build-04-init-database:
	docker exec php-registration bash -c "rm /var/www/data/database.db || true ;sqlite3 /var/www/data/database.db < /var/www/html/table.sql; chmod 777 /var/www/data/database.db"

00-build-05-test-http:
	curl http://127.0.0.1:13380
	curl -X POST -d "name=toto&email=toto@titi.com&username=user01&pwd=p4ssw0rd" http://127.0.0.1:13380/registration.php

00-build-06-stop-webserver:
	docker stop php-registration
	docker ps

00-build-07-restart-webserver:
	docker run \
	  --name php-registration \
	  --rm \
	  --detach \
	  -v $$PWD/db:/var/www/data \
	  -v $$PWD/src:/var/www/html \
	  -p 13380:80 \
	  php-registration
	docker exec php-registration bash -c "sqlite3 /var/www/data/database.db 'select * from USERS;'"

00-build-08-kill-server:
	- docker kill php-registration
	- docker rm $$(docker ps -a --format="{{.Names}}")
