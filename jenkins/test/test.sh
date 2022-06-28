#!/bin/bash

echo "************************"
echo "*** TESTING THE CODE ***"
echo "************************"

WORKSPACE=/var/efs/containers/jenkins/workspace/pipeline-docker-maven

docker run --rm -v $WORKSPACE/java-app/:/app -v /root/.m2:/root/.m2 -w /app maven:3.8.6-jdk-11 "$@"

#docker run --rm -v /home/k8admin/jenkins/pipeline/java-app/:/app -v /root/.m2:/root/.m2 -w /app maven:3.8.6-jdk-11 "$@"
