#!/usr/bin/env bash

CURRENTD=`pwd`

mkdir -p github.com/hashicorp &&\
      cd  github.com/hashicorp &&\
      git clone https://github.com/hashicorp/consul-template.git &&\
      cd consul-template &&\
      git reset --hard 468d743592ab250ca8e9fdcef2002401634fcf75 &&\
      export XC_OS=linux &&\
      export XC_ARCH=amd64 &&\
      make &&\
      cd $CURRENTD



docker build -t open-resty-base .

