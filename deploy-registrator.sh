#!/usr/bin/env bash

# usage deploy-registrator.sh

HOST_NAME=$1
HOST_IP=$2
CONSUL_IP=$3

eval $(docker-machine env ${HOST_NAME})

docker run --rm  -v /var/run/docker.sock:/tmp/docker.sock  gliderlabs/registrator:latest -ip=${HOST_IP}  consul://${CONSUL_IP}:8500
