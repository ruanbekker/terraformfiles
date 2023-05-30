resource "aws_launch_template" "this" {
  name                   = "my-launch-template-${var.node}"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = "my-key"
  vpc_security_group_ids = var.security_group_ids
}
