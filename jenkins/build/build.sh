#!/bin/bash

# Copy the new jar to the build location

cp -f /home/k8admin/jenkins/pipeline/java-app/target/*.jar /home/k8admin/jenkins/pipeline/jenkins/build/

echo "*****************************"
echo "*** Building Docker Image ***"
echo "*****************************"

cd /home/k8admin/jenkins/pipeline/jenkins/build/ && docker-compose -f docker-compose-build.yml build --no-cache

 
