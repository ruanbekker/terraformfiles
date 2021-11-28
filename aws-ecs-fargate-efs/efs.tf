resource "aws_security_group" "efs" {
    name = "${var.team_name}-${var.project_name}-${var.environment_name}-efs-sg"
    description = "Allow ${var.project_name} ECS inbound for EFS"
    vpc_id = data.aws_vpc.vpc.id

    ingress {
        from_port       = 2049
        to_port         = 2049
        protocol        = "tcp"
        security_groups = [
            aws_security_group.ecs_app.id
        ]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name        = "${var.team_name}-${var.project_name}-${var.environment_name}-efs-sg"
        Environment = var.environment_name
        Team        = var.team_name
        ManagedBy   = "terraform"
    }
}

resource "aws_efs_file_system" "ecs" {
    performance_mode = "generalPurpose"
    throughput_mode  = "provisioned"
    provisioned_throughput_in_mibps = "3"

    tags = {
        Name = "${var.team_name}-${var.project_name}-${var.environment_name}"
        Environment = var.environment_name
        Team        = var.team_name
        ManagedBy   = "terraform"
  }
}

resource "aws_efs_mount_target" "efs_mount_a" {
   file_system_id  = aws_efs_file_system.ecs.id
   subnet_id = data.aws_subnet.private_1.id
   security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "efs_mount_b" {
   file_system_id  = aws_efs_file_system.ecs.id
   subnet_id = data.aws_subnet.private_2.id
   security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "efs_mount_c" {
   file_system_id  = aws_efs_file_system.ecs.id
   subnet_id = data.aws_subnet.private_3.id
   security_groups = [aws_security_group.efs.id]
}
