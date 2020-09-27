resource "aws_iam_role" "ec2_access_role" {
  name               = "ec2-role"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

resource "aws_iam_policy_attachment" "readonly_role_policy_attach" {
  name       = "role_policy_attachment"
  roles      = ["${aws_iam_role.ec2_access_role.name}"]
  policy_arn = data.aws_iam_policy.AmazonEC2ReadOnlyAccess.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name  = "instance_profile"
  role = aws_iam_role.ec2_access_role.name
}
