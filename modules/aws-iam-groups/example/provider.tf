terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.23.0"
    }
  }
}

provider "aws" {
  region                   = "eu-west-1"
  profile                  = "personal"
  shared_credentials_files = ["~/.aws/credentials"]
}
