# 04-Multistage-build

## Build

### Build image

`$ make 00-build-01-build-image`

```
docker build \
	  --tag php-registration \
	  .
``` 

### Run web server

`$ make 00-build-02-run-web-server`

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
docker exec php-registration bash -c "rm /var/www/data/database.db || true ;sqlite3 /var/www/data/database.db < /var/www/html/table.sql; chmod 777 /var/www/data/database.db"
``` 

### Test http

`$ make 00-build-03-test-http`

```
curl http://127.0.0.1:13380/styles.css
``` 

### Cleanup

`$ make 00-build-04-cleanup`

```
#- docker kill php-registration
#- docker rm $(docker ps -a --format="{{.Names}}")
``` 

