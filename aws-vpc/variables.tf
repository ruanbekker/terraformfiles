variable "account_role" {
  type        = string
  default     = ""
  description = "The type of AWS Account like prod, dev, data"
}

variable "environment_name" {
  type        = string
  default     = ""
  description = "The service environment"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block of the VPC"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the Private Subnet"
}

variable "aws_region" {
  type        = string
  description = "The AWS Region"
}
