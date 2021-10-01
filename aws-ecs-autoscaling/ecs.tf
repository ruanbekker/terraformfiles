data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.ecs_cluster_name
}

resource "aws_ecr_repository" "worker" {
    name = "${var.team_name}-${var.project_name}-worker-${var.environment_name}"
}

data "template_file" "ecr_lifecycle_policy" {
  template = "${file("templates/ecr_lifecycle_policy.json")}"
  vars = {
    ecr_image_retention_in_count = var.ecr_image_retention_in_count
  }
}

resource "aws_ecr_lifecycle_policy" "worker_lifecycle" {
  repository = aws_ecr_repository.worker.name
  policy = data.template_file.ecr_lifecycle_policy.rendered
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.log_group_name}-${var.environment_name}"
  retention_in_days = 5
}

resource "aws_iam_role" "ecs_task_iam_role" {
  name = "${var.team_name}-${var.project_name}-${var.environment_name}-ecs-task-role"
  description = "Allow ECS tasks to access AWS resources"
  assume_role_policy = file("templates/ecs_iam_assume_role_policy.json")
}

resource "aws_iam_policy" "ecs_task_policy" {
  name   = "${var.team_name}-${var.project_name}-${var.environment_name}-ecs-task-policy"
  policy = file("templates/ecs_iam_task_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ecs_task_iam_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
