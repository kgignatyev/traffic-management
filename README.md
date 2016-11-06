this is demo of traffic management with open resty, Consul, and registrator

https://blog.uship.com/shippingcode/connectivity-between-nginx-and-consul-template/

0 Create machines
----


docker-machine create -d virtualbox default
docker-machine create -d virtualbox host1
docker-machine create -d virtualbox host2
docker-machine create -d virtualbox host3

1 Start machines
----

<pre>
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
default   -        virtualbox   Running   tcp://192.168.99.100:2376           v1.12.1   
host1     -        virtualbox   Running   tcp://192.168.99.101:2376           v1.12.1   
host2     -        virtualbox   Running   tcp://192.168.99.102:2376           v1.12.1
</pre>   

2 Start Consul
----
eval $(docker-machine env default)
docker-compose up

3 Start Registrator on target machines
--------------------------------------

http://gliderlabs.com/registrator/latest/

./deploy-registrator.sh host1 192.168.99.101 192.168.99.100
./deploy-registrator.sh host2 192.168.99.102 192.168.99.100


   at this time we can see that consul console show only consul service at
    http://192.168.99.100:8500/ui/#/vbtdev/services

4 Deploy echo service on one or 2 hosts
---------------------------------------
./deploy-echo-service.sh host1
./deploy-echo-service.sh host2

  http://192.168.99.100:8500/ui/#/vbtdev/services now show one or two instances available

4 Start Nginx on a gateway host
-------------------------------


build base image for OpenResty ( https://openresty.org ) 
and consul-template ( https://github.com/hashicorp/consul-template )
( as of 2016-09-06 requires 0.16 to be compiled to get -exec
 requires go 1.7
http://tecadmin.net/install-go-on-ubuntu/#
)
<pre>
cd nginx-template
eval $(docker-machine env default)
docker build -t openresty-consul-template-base .
</pre>

or latest 
docker build -t openresty-consul-template-base:1.11.2.1 -f Dockerfile2 .


Start consul-template and mount template source directory for easy debug

docker run --rm  -p 8000:80  -v `pwd`/src:/etc/consul-template -ti openresty-consul-template-base:1.11.2.1 bash

inside container 

export PATH=/_/root/bin:$PATH 
this will go away when docker container will be adjusted to include consul template to be on path

consul-template -config=/etc/consul-template/consul-template3.json -consul=192.168.99.100:8500 



Consul UI
http://192.168.99.100:8500

Consul API
http://192.168.99.100:8500/v1/catalog/services






