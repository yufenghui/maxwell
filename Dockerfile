FROM openjdk:11-jre-slim

ENV MAXWELL_VERSION=1.27.0 KAFKA_VERSION=1.0.0


RUN mkdir /app \
    && echo "1.27.0" > /app/REVISION

COPY ./target/maxwell-1.27.0/maxwell-1.27.0 /app

RUN sed -i "s/\r//" /app/bin/maxwell
RUN sed -i "s/\r//" /app/bin/maxwell-benchmark
RUN sed -i "s/\r//" /app/bin/maxwell-bootstrap
RUN sed -i "s/\r//" /app/bin/maxwell-docker

WORKDIR /app


CMD [ "/bin/bash", "-c", "bin/maxwell-docker" ]
