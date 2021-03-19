data "aws_caller_identity" "root" {}

data "aws_caller_identity" "staging" {
    provider = aws.staging
}

data "aws_caller_identity" "tools" {
    provider = aws.tools
}
