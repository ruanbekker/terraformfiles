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
  region  = "eu-west-1"
  profile = "terraform"
  shared_credentials_file = "~/.aws/credentials"
}

provider "random" {}
