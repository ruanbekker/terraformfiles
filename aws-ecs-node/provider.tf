terraform {
  required_providers {
    aws = {
      version = "~> 3.27"
      source = "hashicorp/aws"
    }
    random = {
      version = "~> 3.0"
      source  = "hashicorp/random"
    }
    null = {
      version = "~> 3.0"
      source  = "hashicorp/null"
    }
    template = {
      version = "~> 2.1"
      source  = "hashicorp/template"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "dev"
  shared_credentials_file = "~/.aws/credentials"
}

provider "template" {}
provider "random" {}
provider "null" {}