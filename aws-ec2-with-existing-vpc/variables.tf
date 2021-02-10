variable "region" {
    description = "region"
    default     = "eu-west-1"
}

variable "instance_type" {
    description = "ec2 instance type"
    default     = "t2.nano"
}

variable "instance_name" {
    description = "ec2 instance name"
    default     = "debug"
}

variable "ssh_keypair" {
    description = "keypair"
    default     = "demo"
}

variable "ssh_private_key" {
    description = "ssh private key filepath"
    default     = "~/.ssh/demo.pem"
}
