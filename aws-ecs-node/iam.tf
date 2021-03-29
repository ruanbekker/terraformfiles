data "aws_iam_instance_profile" "ecs_profile" {
  name = var.ec2_iam_instance_profile_name
}
