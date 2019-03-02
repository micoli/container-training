# 01-Basic

## Basic

### Usage

`$ make 00-basic-01-usage`

```
docker
``` 

### Help on command

`$ make 00-basic-02-help-on-command`

```
docker ps --help
``` 

### Get docker version

`$ make 01-basic-01-get-docker-version`

```
docker --version
``` 

### Get docker and subs versions

`$ make 01-basic-02-get-docker-and-subs-versions`

```
docker version
``` 

### Get a detailed overview

`$ make 01-basic-03-get-a-detailed-overview`

```
docker info
``` 

## Docker

### First launch

`$ make 02-docker-01-first-launch`

```
docker run hello-world
``` 

## Image

### List local image

`$ make 03-image-01-list-local-image`

```
docker image ls
``` 

## Containers

### List running

`$ make 04-containers-01-list-running`

```
docker container ls
``` 

### List running all

`$ make 04-containers-02-list-running-all`

```
docker container ls --all
``` 

### List running all quiet

`$ make 04-containers-03-list-running-all-quiet`

```
docker container ls -aq
``` 

