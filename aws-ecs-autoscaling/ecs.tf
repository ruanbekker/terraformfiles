data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.ecs_cluster_name
}

resource "aws_ecs_service" "workers_service" {
    name = "${var.project_name}-workers"
    cluster = data.aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.workers.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [aws_security_group.ecs_workers.id]
        subnets = [data.aws_subnet.private_1.id, data.aws_subnet.private_2.id, data.aws_subnet.private_3.id]
        assign_public_ip = false
    }

}


resource "aws_appautoscaling_target" "workers" {
  max_capacity = 3
  min_capacity = 1
  resource_id = "service/${var.ecs_cluster_name}/${aws_ecs_service.workers_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "memory" {
  name               = "memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.workers.resource_id
  scalable_dimension = aws_appautoscaling_target.workers.scalable_dimension
  service_namespace  = aws_appautoscaling_target.workers.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "cpu" {
  name = "cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.workers.resource_id
  scalable_dimension = aws_appautoscaling_target.workers.scalable_dimension
  service_namespace = aws_appautoscaling_target.workers.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 80
  }
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

resource "aws_security_group" "ecs_workers" {
    name = "${var.team_name}-${var.project_name}-${var.environment_name}-ecs-workers-sg"
    description = "Workers Security Group"
    vpc_id = data.aws_vpc.vpc.id

    ingress {
        from_port = 8793
        to_port = 8793
        protocol = "tcp"
        cidr_blocks = ["${var.base_cidr_block}/16"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.team_name}-${var.project_name}-${var.environment_name}-workers-sg"
        Environment = var.environment_name
        Team        = var.team_name
        ManagedBy   = "terraform"
    }
}


resource "aws_ecs_task_definition" "workers" {
  family = "${var.team_name}-${var.project_name}-${var.environment_name}-workers"
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_task_iam_role.arn
  task_role_arn      = aws_iam_role.ecs_task_iam_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu = "512"
  memory = "2048"
  container_definitions = <<EOF
[
  {
    "name": "airflow-workers",
    "image": ${replace(jsonencode("${aws_ecr_repository.worker.repository_url}:${var.image_version}"), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")} ,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "environment": [
      {
        "name": "AWS_DEFAULT_REGION",
        "value": "eu-west-1"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${var.log_group_name}-${var.environment_name}",
            "awslogs-region": "${var.aws_region}",
            "awslogs-stream-prefix": "workers"
        }
    }
  }
]
EOF

}

