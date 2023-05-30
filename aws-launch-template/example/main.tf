data "aws_caller_identity" "current" {}

data "aws_ami" "packer_node_ami" {
  owners      = [data.aws_caller_identity.current.account_id]
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["${var.ami_prefix}*"]
  }
}

module "my_launch_temlpate" {
  source = "../aws-launch-template"
  node   = "test"
  ami_id = data.aws_ami.packer_node_ami.id
}
