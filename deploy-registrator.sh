#!/usr/bin/env bash

# usage deploy-registrator.sh 1|2

HOST_NAME="host$1"
HOST_IP=`docker-machine ip $HOST_NAME`
CONSUL_IP=`docker-machine ip host3`

tt "reg_$HOST_NAME"

eval $(docker-machine env ${HOST_NAME})

docker run --rm  -v /var/run/docker.sock:/tmp/docker.sock  gliderlabs/registrator:latest -ip=${HOST_IP}  consul://${CONSUL_IP}:8500
