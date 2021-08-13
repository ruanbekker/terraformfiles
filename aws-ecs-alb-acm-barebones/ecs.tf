resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.team_name}-${var.environment_name}-cluster"
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.log_group.name
      }
    }
  }

  tags = {
    Name        = "${var.team_name}-${var.environment_name}-cluster"
    Environment = var.environment_name
    Purpose     = var.tag_purpose
    Owner       = var.tag_owner
    ManagedBy   = var.tag_managedby
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.log_group_name}/${var.environment_name}-cluster"
  retention_in_days = 5
}

resource "aws_iam_role" "ecs_task_iam_role" {
  name = "${var.team_name}-${var.environment_name}-ecs-task-role"
  description = "Allow ECS tasks to access AWS resources"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ecs_task_policy" {
  name  = "${var.team_name}-${var.environment_name}-ecs-task-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ecs_task_iam_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
