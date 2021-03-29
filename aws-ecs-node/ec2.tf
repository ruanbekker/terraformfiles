data "aws_ami" "latest_ecs" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
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
  ami                         = data.aws_ami.latest_ecs.id
  instance_type               = var.instance_type
  subnet_id                   = element(random_shuffle.subnets.result, 1)
  key_name                    = var.ssh_keypair
  vpc_security_group_ids      = [data.aws_security_group.ec2.id]
  associate_public_ip_address = false
  iam_instance_profile        = data.aws_iam_instance_profile.ecs_profile.name
  
  root_block_device {
    volume_type               = "gp2"
    volume_size               = "80"
    delete_on_termination     = true
    tags = {
      Name                    = "${var.instance_name}-ec2-instance"
    }
  }

  lifecycle {
    ignore_changes            = [subnet_id]
  }

  user_data                   = file("userdata/bootstrap.sh")

  tags = {
    Name                      = "${var.instance_name}-ec2-instance"
    PrometheusScrape          = "Enabled"
    PrometheusContainerScrape = "Enabled"
    InstanceLifecycle         = "ondemand"
    ECSClusterName            = var.cluster_name
    Environment               = var.environment_name
    ManagedBy                 = "terraform"
  }

}

