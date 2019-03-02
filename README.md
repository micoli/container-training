# 05-Build-and-Cache

## Build

### Build image

`$ make 00-build-01-build-image`

```
docker build \
	  --build-arg APP_ENV=dev \
	  --tag php-symfony \
	  .
``` 

### Run web server

`$ make 00-build-02-run-web-server`

```
docker kill php-symfony
docker rm php-symfony
docker run \
	  --name php-symfony \
	  --rm \
	  --detach \
	  -p 13380:80 \
	  php-symfony
``` 

### Test http

`$ make 00-build-03-test-http`

```
curl http://127.0.0.1:13380/status
curl http://127.0.0.1:13380/main.css
``` 

### Cleanup

`$ make 00-build-04-cleanup`

```
docker kill php-symfony
docker rm $(docker ps -a --format="{{.Names}}")
``` 

