variable "ami_id" {
  description = "AMI ID for the launch template."
  type        = string
  default     = null
}

variable "node" {
  description = "The node name."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The instance type for the launch template."
  type        = string
  default     = "t2.micro"
}

variable "instance_role_arn" {
  type        = string
  default     = "arn:aws:iam::000000000000:instance-profile/my-custom-iam-role"
  description = "The IAM Instance Profile Role ARN."
}

variable "security_group_ids" {
  type        = list
  default     = ["sg-000900000000000000"]
  description = "A list of security group ids."
}
