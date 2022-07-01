#!/bin/bash

echo "*******************"
echo "***Pushing Image***"
echo "*******************"



echo "***** Logging IN to AWS ECR *****"
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 611601100250.dkr.ecr.ap-south-1.amazonaws.com

echo "***** Tagging Image *****"
docker tag app:$OLD_BUILD_TAG 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:$NEW_BUILD_TAG
docker tag app:$OLD_BUILD_TAG 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:latest

echo "***** Pushing Image *****"
docker push 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:$NEW_BUILD_TAG
docker push 611601100250.dkr.ecr.ap-south-1.amazonaws.com/avangels-test:latest

