#!/usr/bin/env bash

DOCKER_HOST="host$1"

eval $(docker-machine env  ${DOCKER_HOST} )

mvn -f sboot-service-piloted/pom.xml  package
docker build -t echo_service sboot-service-piloted

docker run --rm -p 8000:7700 \
    -e "SERVICE_NAME=echo" \
    -e "SERVICE_TAGS=http,v1" \
    echo_service