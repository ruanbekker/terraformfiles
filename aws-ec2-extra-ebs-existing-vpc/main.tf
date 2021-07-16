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

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Tier = "private"
    Name = "main-private-1b"
  }
}

resource random_id index {
  byte_length = 2
}

locals {
  subnet_ids_list = tolist(data.aws_subnet_ids.private.ids)
  subnet_ids_random_index = random_id.index.dec % length(data.aws_subnet_ids.private.ids)
  instance_subnet_id = local.subnet_ids_list[local.subnet_ids_random_index]
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
  availability_zone = "eu-west-1b"
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
  subnet_id                   = local.instance_subnet_id
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
