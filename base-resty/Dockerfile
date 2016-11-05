FROM ubuntu:16.10

COPY github.com/hashicorp/consul-template/pkg/linux_amd64/consul-template /usr/local/bin/

RUN apt-get update &&\
    apt-get -y install libreadline-dev libncurses5-dev libpcre3-dev \
      libssl-dev perl make build-essential curl git dirmngr software-properties-common apt-transport-https && \
    mkdir /home/root && cd /home/root && \
    curl -o openresty-1.11.2.1.tar.gz  https://openresty.org/download/openresty-1.11.2.1.tar.gz && \
    tar -xzf openresty-1.11.2.1.tar.gz && \
    rm  openresty-1.11.2.1.tar.gz && \
    cd openresty-1.11.2.1 && \
    ./configure  && \
    make && \
    make install &&\
    chmod 755 /usr/local/bin/consul-template


