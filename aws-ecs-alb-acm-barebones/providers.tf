terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.1.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
  shared_credentials_file = "~/.aws/credentials"
}
