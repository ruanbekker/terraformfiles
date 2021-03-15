variable "account_role" {
  type        = string
  default     = ""
  description = ""
}

variable "environment_name" {
  type        = string
  default     = ""
  description = ""
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
}

variable "aws_region" {
  type        = string
  description = "The AWS Region"
}

variable "availability_zones" {
  type        = list
  description = "The az that the resources will be launched"
}
