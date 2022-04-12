#!/bin/bash

ECRRepository=$(aws ecr describe-repositories --query 'repositories[?repositoryName==`joienergy`].repositoryUri|[0]' --output text)

docker build -t joienergy:latest JOIEnergy/
docker tag joienergy:latest $ECRRepository:latest
docker push $ECRRepository:latest
