terraform {
  backend "s3" {
    bucket = "joienergy-bucket"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "3.47.0"
    }
  }
}

provider "docker" {}
provider "aws" {
    region = "us-west-2"
}

resource "aws_ecr_repository" "ecr" {
  name                 = "joienergy"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
   Env = "prod"
 }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "joienergy-cluster"
}

resource "aws_ecs_service" "joienergyapi" {
  name            = "joienergyapi"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 2
}

# output "ecr_repository_joienergyapi_endpoint" {
#   value = aws_ecr_repository.joienergyapi.repository_url
# }