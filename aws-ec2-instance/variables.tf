variable "default_tags" {
  default = {
    Environment = "test"
    Owner       = "ruan.bekker"
    Project     = "terraform-blogpost"
    CostCenter  = "engineering"
    ManagedBy   = "terraform"
  }
}

variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "the region to use in aws"
}

variable "vpc_id" {
  type        = string
  description = "the vpc to use"
}

variable "ssh_keyname" {
  type        = string
  description = "ssh key to use"
}

variable "subnet_id" {
  type        = string
  description = "the subnet id where the ec2 instance needs to be placed in"
}

variable "instance_type" {
  type        = string
  default     = "t3.nano"
  description = "the instance type to use"
}

variable "project_id" {
  type        = string
  default     = "terraform-blogpost"
  description = "the project name"
}

variable "ebs_root_size_in_gb" {
  type        = number
  default     = 10
  description = "the size in GB for the root disk"
}

variable "environment_name" {
   type    = string
   default = "dev"
   description = "the environment this resource will go to (assumption being made theres one account)"
}

