#!/bin/bash

# Check if docker is installed

echo -n "Checking if docker is installed..."

check=`docker --version`
if [ -z "$check" ]; then
  echo "FAILED"
  echo "Docker is not installed. Please install docker first. https://docs.docker.com/install/"
  exit 1
fi
echo "OK"

# Check if AWS CLI is installed

echo -n "Checking if AWS CLI is installed..."

check=`which aws`
if [ -z "$check" ]; then
  echo "FAILED"
  echo "AWS CLI is not installed. Please install and configure it and try again. https://aws.amazon.com/cli/"
  exit 1
fi
echo "OK"

# Check if terraform is installed

echo -n "Checking if terraform is installed..."

check=`which terraform`
if [ -z "$check" ]; then
  echo "FAILED"
  echo "Terraform is not installed. Please install terraform before continuing. https://www.terraform.io/downloads.html"
  exit 1
fi
echo "OK"

# Check if AWS CLI is authenticated

echo -n "Checking if AWS CLI is authenticated..."
check=`aws sts get-caller-identity`
if [ -z "$check" ]; then
  echo "FAILED"
  echo "AWS CLI is not authenticated. Please run 'aws configure' and try again."
  exit 1
fi
echo "OK"

echo "All prerequisites are met."
