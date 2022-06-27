#!/bin/bash

echo "********************"
echo "*** Building JAR ***"
echo "********************"


docker run --rm -v /home/k8admin/jenkins/pipeline/java-app/:/app -v /root/.m2:/root/.m2 -w /app maven:3.8.6-jdk-11 "$@"
