this is demo of traffic management with open resty, Consul, and registrator

https://blog.uship.com/shippingcode/connectivity-between-nginx-and-consul-template/

0 Create machines (if needed)
-----------------------------


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
host3     -        virtualbox   Running   tcp://192.168.99.103:2376           v1.12.1
</pre>   

2 Start Consul
----
eval $(docker-machine env host3)

docker run --rm -p 8400:8400 -p 8500:8500  consul agent -datacenter=kgi -server  -client=0.0.0.0 -bootstrap -ui

3 Start Registrator on machines host1 and host2
-----------------------------------------------

http://gliderlabs.com/registrator/latest/

./deploy-registrator.sh 1 
./deploy-registrator.sh 2 


   at this time we can see that consul console show only consul service at
    http://192.168.99.103:8500/ui/#/vbtdev/services

4 Deploy echo service on one or 2 hosts
---------------------------------------
./deploy-echo-service.sh host1
./deploy-echo-service.sh host2

  http://192.168.99.103:8500/ui/#/vbtdev/services now show one or two instances available

4 Start Nginx on a gateway host
-------------------------------


build base image for OpenResty ( https://openresty.org ) 
and consul-template ( https://github.com/hashicorp/consul-template )
( as of 2016-11-05 requires 0.17 to be compiled to get -exec )
<pre>
cd nginx-template
eval $(docker-machine env default)
docker build -t openresty-consul-template-base .
</pre>

or latest 
docker build -t openresty-consul-template-base:1.11.2.1 -f Dockerfile2 .


Start consul-template and mount template source directory for easy debug


docker run  -d -p 8000:80 -v `pwd`/kgi-apigateway-config:/etc/consul-template voicebox/apigateway:1.0.20160919.20 consul-template -config=/etc/consul-template/consul-template.json -consul=10.45.1.211:8500

inside container 


consul-template -config=/etc/consul-template/consul-template3.json -consul=192.168.99.100:8500 



Consul UI
http://192.168.99.103:8500

Consul API
http://192.168.99.103:8500/v1/catalog/services






