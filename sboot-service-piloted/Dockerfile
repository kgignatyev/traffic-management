FROM anapsix/alpine-java:jdk8

ENV CONTAINERPILOT_VERSION 2.4.1
ENV SVC_VERSION 1.0-SNAPSHOT

COPY target/sboot-service-piloted-${SVC_VERSION}.jar /opt/vbt/services/sboot-service-piloted-${SVC_VERSION}.jar
#COPY src/main/docker/etc/containerpilot.json /etc/

#RUN apk add --no-cache unzip bc curl

#RUN apk add --no-cache unzip bc curl \
#    && export CP_SHA1=198d96c8d7bfafb1ab6df96653c29701510b833c \
#    && curl -Lso /tmp/containerpilot.tar.gz \
#         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
#    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
#    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
#    && rm /tmp/containerpilot.tar.gz

#CMD [ "/bin/containerpilot", "-config", "file:///etc/containerpilot.json", \
#  "bash", "-c", "java -jar /opt/vbt/services/sboot-service-piloted-${SVC_VERSION}.jar" ]

CMD [  "bash", "-c", "java -jar /opt/vbt/services/sboot-service-piloted-${SVC_VERSION}.jar" ]

EXPOSE 7700