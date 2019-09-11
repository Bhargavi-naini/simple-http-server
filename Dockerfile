#FROM rabbitmq:3-management
FROM ubuntu:16.04

COPY . /tmp/src

RUN mkdir -p /tmp/scripts

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
  chmod -R g+w /tmp/src && \
    rm -rf /tmp/scripts && \
    mv /tmp/src/.s2i/bin /tmp/scripts

#USER 1001

LABEL io.k8s.description="kafka Server" \

      io.k8s.display-name="kafka Server" \

      io.openshift.s2i.scripts-url="image:///opt/app-root/s2i" \

      io.openshift.expose-services="1212:http" \

      io.openshift.tags="builder,http"


ENV KAFKA_HOME /usr/local/kafka
ADD ./start-kafka.sh /scripts/

# install java + others
RUN apt-get update && apt-get install -y \
  wget \
  openjdk-8-jdk

# install kafka
RUN wget https://www.mirrorservice.org/sites/ftp.apache.org/kafka/2.3.0/kafka_2.11-2.3.0.tgz && \
    tar -xvf kafka_2.11-2.3.0.tgz && \
  mv kafka_2.11-2.3.0 $KAFKA_HOME





	


# Add passwd template file for nss_wrapper

#RUN chmod +x /tmp/src/.s2i/bin/assemble
#RUN /tmp/src/.s2i/bin/assemble

# ''RUN chmod +x /tmp/scripts/assemble
# ''RUN /tmp/scripts/assemble

#RUN chmod +x /opt/app-root/s2i/run
#CMD [ "/opt/app-root/s2i/run" ]


#

# entrypoint/cmd for container

#CMD ["/tmp/rabbitmq/run-rabbitmq-server.sh"]


