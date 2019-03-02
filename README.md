# 03-Building-image

## Build

### Build image

`$ make 00-build-01-build-image`

```
docker build \
	  --tag php-registration \
	  .
``` 

### Push

`$ make 00-build-02-push`

```
echo "docker login"
echo "docker tag php-registration micoli/php-registration"
``` 

### Run web server

`$ make 00-build-03-run-web-server`

```
docker kill php-registration
docker rm php-registration
docker run \
	  --name php-registration \
	  --rm \
	  --detach \
	  -v $PWD/db:/var/www/data \
	  -p 13380:80 \
	  php-registration
``` 

### Init database

`$ make 00-build-04-init-database`

```
docker exec php-registration bash -c "rm /var/www/data/database.db || true ;sqlite3 /var/www/data/database.db < /var/www/html/table.sql; chmod 777 /var/www/data/database.db"
``` 

### Test http

`$ make 00-build-05-test-http`

```
curl http://127.0.0.1:13380
curl -X POST -d "name=toto&email=toto@titi.com&username=user01&pwd=p4ssw0rd" http://127.0.0.1:13380/registration.php
``` 

### Stop webserver

`$ make 00-build-06-stop-webserver`

```
docker stop php-registration
docker ps
``` 

### Restart webserver

`$ make 00-build-07-restart-webserver`

```
docker run \
	  --name php-registration \
	  --rm \
	  --detach \
	  -v $PWD/db:/var/www/data \
	  -v $PWD/src:/var/www/html \
	  -p 13380:80 \
	  php-registration
docker exec php-registration bash -c "sqlite3 /var/www/data/database.db 'select * from USERS;'"
``` 

### Kill server

`$ make 00-build-08-kill-server`

```
docker kill php-registration
docker rm $(docker ps -a --format="{{.Names}}")
``` 

