terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
  required_version = ">= 1.2.4"
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = var.region
}

provider "template" {}
