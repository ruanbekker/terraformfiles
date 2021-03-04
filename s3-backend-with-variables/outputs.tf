output "policy_arn" {
  value = data.aws_iam_policy.AmazonEC2ReadOnlyAccess.arn
}

output "policy_arn2" {
  value = data.aws_iam_policy.AmazonEC2ContainerServiceforEC2Role.arn
}
