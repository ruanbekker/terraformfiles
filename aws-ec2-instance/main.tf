data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-*-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ec2_read_only_access" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_role" "ec2_access_role" {
  name               = "${local.project_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy_attachment" "readonly_role_policy_attach" {
  name       = "${local.project_name}-ec2-role-attachment"
  roles      = [aws_iam_role.ec2_access_role.name]
  policy_arn = data.aws_iam_policy.ec2_read_only_access.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name  = "${local.project_name}-ec2-instance-profile"
  role = aws_iam_role.ec2_access_role.name
}

resource "aws_security_group" "ec2" {
    name        = "${local.project_name}-ec2-sg"
    description = "${local.project_name}-ec2-sg"
    vpc_id      = var.vpc_id

    tags = merge(
      var.default_tags,
      {
       Name = "${local.project_name}-ec2-sg"
      },
    )
}

resource "aws_security_group_rule" "ssh" {
    description       = "allows public ssh access to ec2"
    security_group_id = aws_security_group.ec2.id
    type              = "ingress"
    protocol          = "tcp"
    from_port         = 22
    to_port           = 22
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
    description       = "allows egress"
    security_group_id = aws_security_group.ec2.id
    type              = "egress"
    protocol          = "-1"
    from_port         = 0
    to_port           = 0
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.ssh_keyname
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true
  monitoring                  = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  lifecycle {
    ignore_changes            = [subnet_id, ami]
  }

  root_block_device {
      volume_type           = "gp2"
      volume_size           = var.ebs_root_size_in_gb
      encrypted             = false
      delete_on_termination = true
  }

  tags = merge(
    var.default_tags,
    {
     Name = "${local.project_name}"
    },
  )

}

