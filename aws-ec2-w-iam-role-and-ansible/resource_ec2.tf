locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
touch /tmp/userdata.txt
EOF
}

resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = local.instance_subnet_id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  key_name               = var.ssh_key_name
  vpc_security_group_ids = ["${aws_security_group.my_sg.id}"]
  associate_public_ip_address = true
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
    Name                              = "${var.instance_name}"
    PrometheusScrapeEnabled           = "${var.tags["true"]}"
    PrometheusContainerScrapeEnabled  = "${var.tags["false"]}"
  }

  provisioner "file" {
    source      = "scripts/script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.ssh_key["aws_dev"])
      host        = self.public_dns
    }
  }

  provisioner "local-exec" {
    command = "echo private: ${aws_instance.my_instance.private_ip} > instance_details.txt && echo public: ${aws_instance.my_instance.public_ip} >> instance_details.txt"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash -c /tmp/script.sh",
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.ssh_key["aws_dev"])
      host        = aws_instance.my_instance.public_ip
      timeout     = "2m"
    }

  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.my_instance.public_ip
      private_key  = file(var.ssh_key["aws_dev"])
      timeout     = "2m"
    }
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "[nginx]" > nginx.ini
      echo "${aws_instance.my_instance.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.ssh_key["aws_dev"]}" >> nginx.ini
      ansible-playbook -u ${var.ansible_user} --private-key ${var.ssh_key["aws_dev"]} -i nginx.ini ansible/playbook.yml
      EOT
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my-test-sg"
  description = "my-test-sg"
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.my_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.my_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.my_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
