FROM java:8-jdk

MAINTAINER John Erik Halse

ENV PROTOBUF_VERSION 2.5.0

RUN apt-get update && \
apt-get install -y maven cmake build-essential pkg-config libssl-dev zlib1g-dev automake autoconf make && rm -rf /var/lib/apt/lists/*

#ENV PROTOBUF_VERSION 2.5.0-9ubuntu1

RUN wget http://protobuf.googlecode.com/files/protobuf-${PROTOBUF_VERSION}.tar.gz; \
  tar xzvf protobuf-${PROTOBUF_VERSION}.tar.gz; \
  cd protobuf-${PROTOBUF_VERSION}; \
  ./configure; \
  make; \
  make check; \
  make install; \
  ldconfig; \
  protoc --version


ENV HADOOP_VERSION 2.7.1

RUN cd /; \
  wget http://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}-src.tar.gz; \
  tar -xzf hadoop-${HADOOP_VERSION}-src.tar.gz; \
  cd hadoop-${HADOOP_VERSION}-src; \
  mvn package -Pdist,native -DskipTests -Dtar

RUN cd /; \
  ln -s hadoop-${HADOOP_VERSION}-src hadoop
  
CMD /bin/bash

