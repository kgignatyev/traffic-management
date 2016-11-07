#!/usr/bin/env bash


eval $(docker-machine env host3)

docker run --rm -p 8400:8400 -p 8500:8500  consul agent -datacenter=kgi -server  -client=0.0.0.0 -bootstrap -ui