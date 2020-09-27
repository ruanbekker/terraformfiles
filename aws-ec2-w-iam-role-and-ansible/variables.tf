variable "region" {
    description - "the aws region to use"
    default     = "eu-west-1"
}

variable "ssh_user" {
    description = "the ssh user to use"
    default     = "ubuntu"
}

variable "ssh_key" {
    type = map(string)
    default = {
        aws_prod = "~/.ssh/prod.pem"
        aws_dev  = "~/.ssh/terraform.pem"
    }
}

variable "private_key" {
    description = "the private key to use"
    default     = "~/.ssh/terraform.pem"
}

variable "ssh_key_name" {
    description = "the aws ssh key to logon to the instance"
    default     = "terraform"
}

variable "ansible_user" {
    description = "the user that ansible will use to ssh"
    default     = "ubuntu"
}

variable "instance_name" {
    default = "my-ec2-instance"
}

variable "tags" {
    type = map(string)
    default = {
        name          = "my-ec2-instance"
        true          = "Enabled"
        false         = "Disabled"
    }
}
