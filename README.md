# 06-Dockercompose

## Docker compose

### Up

`$ make 00-docker-compose-01-up`

```
docker-compose down
docker-compose up -d
``` 

### Monitoring

`$ make 00-docker-compose-02-monitoring`

```
docker-compose ps
docker-compose logs
docker-compose logs redis-cache
``` 

### Check results

`$ make 00-docker-compose-03-check-results`

```
curl http://127.0.0.1:4000/status
``` 

### Launch command

`$ make 00-docker-compose-04-launch-command`

```
docker-compose exec application bin/console
``` 

### Cleanup

`$ make 00-docker-compose-05-cleanup`

```
#- docker-compose down
``` 

