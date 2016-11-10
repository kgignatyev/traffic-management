this is demo of traffic management with open resty, Consul, and registrator



0 Create machines (if necessary)
--------------------------------


docker-machine create -d virtualbox default
docker-machine create -d virtualbox host1
docker-machine create -d virtualbox host2
docker-machine create -d virtualbox host3


1 Start machines
----

docker-machine start default
docker-machine start host1
docker-machine start host2
docker-machine start host3


<pre>
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
default   -        virtualbox   Running   tcp://192.168.99.100:2376           v1.12.1   
host1     -        virtualbox   Running   tcp://192.168.99.101:2376           v1.12.1   
host2     -        virtualbox   Running   tcp://192.168.99.102:2376           v1.12.1
host3     -        virtualbox   Running   tcp://192.168.99.103:2376           v1.12.1
</pre>   

  (regenerate certs if necessary docker-machine regenerate-certs default host1 host2 host3 )
  
1.1 Build parts
------
cd base-resty; ./build-base-image.sh; cd -

cd api-gateway; ./build-gateway-image.sh; cd -
  
  
  
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
    http://192.168.99.103:8500

4 Deploy echo service on one or 2 hosts
---------------------------------------
./deploy-echo-service.sh host1
./deploy-echo-service.sh host2

  http://192.168.99.103:8500/ui/#/vbtdev/services now show one or two instances available

4 Start Nginx on a gateway host
-------------------------------


Consul UI
http://192.168.99.103:8500

Consul API
http://192.168.99.103:8500/v1/catalog/services


Echo-service call
http://192.168.99.100:8000/api/echo-service/headers


we can manage registration info by simply specifying different environment 
variables
docker run --rm  -P \
    -e "SERVICE_NAME=echo-service-test" \
    -e "SERVICE_TAGS=http,v1-candidate" \
    echo-service


docker-machine stop host3 host2 host1 default


Useful Links
------

https://blog.uship.com/shippingcode/connectivity-between-nginx-and-consul-template/

http://blog.cloud66.com/9-crtitical-decisions-needed-to-run-docker-in-production/

https://www.consul.io/

https://github.com/hashicorp/consul-template

https://openresty.org/en/

https://github.com/hashicorp/envconsul


https://studio.zerobrane.com/
Debugging Lua on nginx server
http://notebook.kulchenko.com/zerobrane/debugging-openresty-nginx-lua-scripts-with-zerobrane-studio



Register a service manually

curl -X PUT 192.168.99.104:8500/v1/catalog/register \
  --data @register-service.json





