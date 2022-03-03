terraform {
  required_providers {
    aws = {
      version = "~> 3.27"
      source = "hashicorp/aws"
    }
    random = {
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "prod"
  shared_credentials_file = "~/.aws/credentials"
}

variable "region" {
  type        = string
  description = "The default region for the application / deployment"

  validation {
    condition = contains([
      "eu-west-1",
      "af-south-1"
    ], var.region)
    error_message = "Invalid region provided."
  }
}

data "aws_vpc" "default" {
  default = true
  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}
