terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.30.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "dev"
  shared_credentials_file = "~/.aws/credentials"
}
