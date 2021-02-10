resource "aws_security_group" "sg" {
  name        = "${var.instance_name}-dev-sg"
  description = "${var.instance_name}-dev-sg"
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
