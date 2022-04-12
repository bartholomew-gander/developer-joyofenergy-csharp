#!/bin/bash

# Check if S3 bucket called joienergy-bucket already exists

echo -n "Checking if S3 bucket called joienergy-bucket already exists..."

if aws s3api head-bucket --bucket joienergy-bucket > /dev/null 2>&1; then
    echo "OK"
else
    echo "Trying to create..."
    aws s3 mb s3://joienergy-bucket
    
fi

echo "Applying terraform plan..."
terraform -chdir=deployment/terraform init
terraform -chdir=deployment/terraform apply -target=aws_ecr_repository.ecr -auto-approve

echo "Logging in to ECR..."
ECRRepository=$(aws ecr describe-repositories --query 'repositories[?repositoryName==`joienergy`].repositoryUri|[0]' --output text)
aws ecr get-login-password | docker login --username AWS --password-stdin $ECRRepository
