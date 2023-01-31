variable "iam_user_name" {
  type        = string
  default     = "john.doe"
  description = "the iam user that will be created"
}

variable "iam_group_name" {
  type        = string
  default     = "test-group"
  description = "the iam group that will be created"
}

resource "aws_iam_user" "john" {
  name = var.iam_user_name
  path = "/user/"

  tags = {
    email = "${var.iam_user_name}@example.com"
  }
}

# iam group
resource "aws_iam_group" "iam-access-group" {
  name = var.iam_group_name
  path = "/users/"
}

# iam group permissions
resource "aws_iam_group_policy" "iam-group-access-policy" {
  name  = "group-access-policy"
  group = aws_iam_group.iam-access-group.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:PassRole",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "user-permissions-01" {
  group      = aws_iam_group.iam-access-group.name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_group_policy_attachment" "user-permissions-02" {
  group      = aws_iam_group.iam-access-group.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# associate user to the iam group
resource "aws_iam_user_group_membership" "user-group-membership" {
  user   = aws_iam_user.john.name

  groups = [
    aws_iam_group.iam-access-group.name
  ]
}
