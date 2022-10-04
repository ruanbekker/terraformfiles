variable "region" {
  type        = string
  default     = "us-east-1"
  description = "the region to use in aws"
}

variable "vpc_id" {
  type        = string
  description = "the vpc id to use"
}

variable "key_file" {
  type        = string
  description = "ssh key file to use"
  default     = "~/.ssh/id_rsa.pub"
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

variable "project_identifier" {
  type        = string
  default     = "terraform-userdata"
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

variable "owner_name" {
   type    = string
   default = "casper"
   description = "the owner of this resource - mostly used for tagging"
}

variable "team_name" {
   type    = string
   default = "devops"
   description = "the team that will be responsible for this resource - mostly for naming conventions and tagging"
}

variable "arch" {
  type        = string
  default     = "x86_64"
  description = "architecture"
}
