terraform {
  required_providers {
    aws = {
      version = ">= 3.32.0"
      source = "hashicorp/aws"
    }
    random = {
      version = ">= 3.1.0"
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "dev"
  shared_credentials_file = "~/.aws/credentials"
}

provider "random" {}
