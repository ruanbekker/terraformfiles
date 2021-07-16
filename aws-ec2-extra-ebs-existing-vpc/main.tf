locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
touch /tmp/userdata.txt
EOF
}

data "aws_vpc" "default" {
  default = true
  tags = {
    Name = "main"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = 1
}

data "aws_subnet" "private" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = random_shuffle.az.result[0]
  tags = {
    Tier = "private"
  }
}

data "aws_ami" "latest_ubuntu" {
most_recent = true
owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_security_group" "remote_access" {
  name   = var.security_group
  vpc_id = data.aws_vpc.default.id
}

resource "aws_ebs_volume" "example" {
  availability_zone = random_shuffle.az.result[0]
  size              = 30
  tags = {
    Name        = var.instance_name
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

resource "aws_instance" "my_instance" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.private.id
  key_name                    = var.ssh_key_name["dev"]
  vpc_security_group_ids      = [data.aws_security_group.remote_access.id]
  associate_public_ip_address = false
  
  lifecycle {
    ignore_changes            = [subnet_id,ami]
  }

  user_data_base64 = base64encode(local.user_data)

  root_block_device {
      volume_type           = "gp2"
      volume_size           = 20
      encrypted             = false
      delete_on_termination = true
  }

  tags = {
    Name        = var.instance_name
    Environment = "dev"
    ManagedBy   = "terraform"
  }

  provisioner "local-exec" {
    command = "echo private: ${aws_instance.my_instance.private_ip} > instance_details.txt"
  }

}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.my_instance.id
}
