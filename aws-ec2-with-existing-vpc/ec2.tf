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

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = element("${random_shuffle.subnets.result}", 1)
  key_name               = var.ssh_keypair
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  associate_public_ip_address = true

  lifecycle {
    ignore_changes       = [subnet_id,ami]
  }

  user_data_base64       = base64encode(local.user_data)

  tags = {
    Name                 = var.instance_name
  }

}
