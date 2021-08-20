terraform {
  required_providers {
    aws = {
      version = "~> 3.27"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
  shared_credentials_file = "~/.aws/credentials"
}

variable "tag_name" {
   type    = string
   default = "bastion"
}

data "aws_instance" "ec2" {
  filter {
    name   = "tag:Name"
    values = [var.tag_name]
  }
}

output "id" {
  description = "The ec2 instance id"
  value       = data.aws_instance.ec2.id
}

output "ip" {
  description = "The ec2 instance private ip address"
  value       = data.aws_instance.ec2.private_ip
}
