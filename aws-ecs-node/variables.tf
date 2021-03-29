variable "region" {
    description = "region"
    default     = "eu-west-1"
}

variable "instance_type" {
    description = "ec2 instance type"
    default     = "t3a.medium"
}

variable "instance_name" {
    description = "ec2 instance name"
    default     = "ecs-dev"
}

variable "cluster_name" {
    description = "ecs cluster name"
    default     = "ecs-dev"
}

variable "environment_name" {
    description = "ecs container instance environment name"
    default     = "dev"
}

variable "ssh_keypair" {
    description = "keypair"
    default     = "dev"
}

variable "ssh_private_key" {
    description = "ssh private key filepath"
    default     = "~/.ssh/dev.pem"
}

variable "ec2_iam_instance_profile_name" {
    description = "the instance profile name"
    default     = "ecs-dev-instance-role"
}