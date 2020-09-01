FROM openjdk:11-jre-slim

ENV MAXWELL_VERSION=1.27.1 KAFKA_VERSION=1.0.0


RUN mkdir /app \
    && echo "1.27.1" > /app/REVISION

COPY ./target/maxwell-1.27.1/maxwell-1.27.1 /app

# 解决Windows中编辑的脚本到Linux上回车换行报错的问题
RUN sed -i "s/\r//" /app/bin/maxwell
RUN sed -i "s/\r//" /app/bin/maxwell-benchmark
RUN sed -i "s/\r//" /app/bin/maxwell-bootstrap
RUN sed -i "s/\r//" /app/bin/maxwell-docker

WORKDIR /app


CMD [ "/bin/bash", "-c", "bin/maxwell-docker" ]
