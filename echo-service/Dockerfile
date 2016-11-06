FROM anapsix/alpine-java:jdk8


ENV SVC_VERSION 1.0-SNAPSHOT

COPY target/echo-service-${SVC_VERSION}.jar /opt/dev9/services/echo-service-${SVC_VERSION}.jar

CMD [  "bash", "-c", "java -jar /opt/dev9/services/echo-service-${SVC_VERSION}.jar" ]

EXPOSE 7700