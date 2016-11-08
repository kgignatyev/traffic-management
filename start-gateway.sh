#!/usr/bin/env bash


CONSUL_IP=`docker-machine ip host3`

eval $(docker-machine env default)

docker run  --rm -p 8000:80 --label type=api-gateway  api-gateway consul-template -config=/etc/consul-template/consul-template.json -consul=$CONSUL_IP:8500
