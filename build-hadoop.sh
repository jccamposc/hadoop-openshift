#!/bin/bash

NS=norsknettarkiv
BUILDER_TAG=1.0.0
DEPLOY_TAG=0.1.0-BETA


find ./ -name '*~' -exec rm '{}' \;


############################
# Build Hadoop from source #
############################

docker build -t ${NS}/build-hadoop:${BUILDER_TAG} hadoop-build

docker run --name=build-hadoop ${NS}/build-hadoop:${BUILDER_TAG}

# Find the Hadoop version environment variable
for var in `docker inspect --format='{{range .Config.Env}}{{.}} {{end}}' build-hadoop`; do
    export ${var}
done;

echo Hadoop version: ${HADOOP_VERSION}

# Copy the built Hadoop distribution
docker cp build-hadoop:"hadoop/hadoop-dist/target/hadoop-${HADOOP_VERSION}.tar.gz" hadoop-openshift/

docker rm build-hadoop


############################
# Create docker image      #
############################

docker build -t ${NS}/hadoop-openshift:${DEPLOY_TAG} hadoop-openshift


############################
# Push to Docker Hub       #
############################

docker push ${NS}/hadoop-openshift:${DEPLOY_TAG}


############################
# Clean up                 #
############################

rm hadoop-openshift/hadoop-*.tar.gz

