resource "aws_instance" "my_instance" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = local.instance_subnet_id
  key_name                    = "my_key"
  vpc_security_group_ids      = ["${aws_security_group.this_sg.id}"]
  associate_public_ip_address = false
  
  lifecycle {
    ignore_changes       = [subnet_id]
  }

  user_data_base64 = base64encode(local.user_data)

  root_block_device {
      volume_type           = "gp2"
      volume_size           = 20
      encrypted             = false
      delete_on_termination = true
  }

  tags = {
    Name = "${var.instance_name}"
  }

  provisioner "file" {
    source      = "scripts/script.sh"
    destination = "/tmp/script.sh"
    
    connection {
      type                = "ssh"
      user                = "ubuntu"
      host                = self.private_ip
      private_key         = file("${var.ssh_private_key}")
      bastion_host        = var.bastion["host"]
      bastion_user        = var.bastion["user"]
      bastion_private_key = file("${var.bastion["private_key"]}")
    }
  }
}

resource "aws_security_group" "this_sg" {
  name        = "my-dev-sg"
  description = "my-dev-sg"
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.this_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["172.31.0.0/16"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.this_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
