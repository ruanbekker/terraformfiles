data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.ecs_cluster_name
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.log_group_name}-${var.environment_name}"
  retention_in_days = 5
}

data "aws_security_group" "application_load_balancer" {
  name   = var.alb_sg_name
}

resource "aws_security_group" "ecs_app" {
    name = "${var.team_name}-${var.project_name}-${var.environment_name}-ecs-app-sg"
    description = "allows traffic from alb to ecs"
    vpc_id = data.aws_vpc.vpc.id

    ingress {
        from_port       = 8080
        to_port         = 8080
        protocol        = "tcp"
        security_groups = [data.aws_security_group.application_load_balancer.id]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name        = "${var.team_name}-${var.project_name}-${var.environment_name}-ecs-sg"
        Environment = var.environment_name
        Team        = var.team_name
        ManagedBy   = "terraform"
    }
}

resource "aws_ecs_task_definition" "app" {
  family = "${var.team_name}-${var.project_name}-app-${var.environment_name}"
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_task_iam_role.arn
  task_role_arn      = aws_iam_role.ecs_task_iam_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu = "512"
  memory = "1024"
  container_definitions = <<EOF
[
  {
    "name": "app",
    "image": "nginx:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/var/www/html",
        "sourceVolume": "efs-storage"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${var.log_group_name}-${var.environment_name}",
            "awslogs-region": "${var.aws_region}",
            "awslogs-stream-prefix": "web-server"
        }
    }
  }
]
EOF

  volume {
    name      = "efs-storage"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.ecs.id
      root_directory = "/var/www/html"
    }
  }

}
