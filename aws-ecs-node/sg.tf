data "aws_security_group" "ec2" {
  name = "${var.cluster_name}-ec2-sg"
}
