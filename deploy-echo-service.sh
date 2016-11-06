#!/usr/bin/env bash

DOCKER_HOST="host$1"

eval $(docker-machine env  ${DOCKER_HOST} )

mvn -f echo-service/pom.xml  package
docker build -t echo-service echo-service

docker run --rm  -P \
    -e "SERVICE_NAME=echo-service" \
    -e "SERVICE_TAGS=http,v1" \
    echo-service