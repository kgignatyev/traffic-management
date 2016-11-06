#!/usr/bin/env bash

eval $(docker-machine env  default )

docker build -t api-gateway .