variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "The aws region."
}


variable "aws_role_arn" {
  type        = string
  default     = "arn:aws:iam::000000000000:role/terraform-9role"
  description = "The IAM role that allows to assume."
}

variable "ami_prefix" {
  type        = string
  default     = "packer-test"
  description = "The AMI prefix which packer built"
}
