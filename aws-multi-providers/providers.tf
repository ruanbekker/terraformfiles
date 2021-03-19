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
  profile = "root"
  shared_credentials_file = "~/.aws/credentials"
}

provider "aws" {
  alias   = "staging"
  region  = "eu-west-1"
  profile = "staging"
  shared_credentials_file = "~/.aws/credentials"
}

provider "aws" {
  alias   = "tools"
  region  = "eu-west-1"
  profile = "tools"
  shared_credentials_file = "~/.aws/credentials"
}
