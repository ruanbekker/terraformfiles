terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.1.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "demo"
  shared_credentials_file = "~/.aws/credentials"
}

provider "random" {}
provider "null" {}
provider "archive" {}
