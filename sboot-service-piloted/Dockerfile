FROM anapsix/alpine-java:jdk8


ENV SVC_VERSION 1.0-SNAPSHOT

COPY target/sboot-service-piloted-${SVC_VERSION}.jar /opt/vbt/services/sboot-service-piloted-${SVC_VERSION}.jar

CMD [  "bash", "-c", "java -jar /opt/vbt/services/sboot-service-piloted-${SVC_VERSION}.jar" ]

EXPOSE 7700