resource "aws_security_group" "alb" {
    name = "${var.team_name}-${var.environment_name}-alb-sg"
    description = "${var.team_name}-${var.environment_name}-alb-sg"
    vpc_id = data.aws_vpc.vpc.id

    tags = {
        Name        = "${var.team_name}-${var.environment_name}-alb-sg"
        Environment = var.environment_name
        Team        = var.team_name
        ManagedBy   = "terraform"
    }
}

resource "aws_security_group" "ecs" {
    name = "${var.team_name}-${var.environment_name}-ecs-sg"
    description = "${var.team_name}-${var.environment_name}-ecs-sg"
    vpc_id = data.aws_vpc.vpc.id

    tags = {
        Name        = "${var.team_name}-${var.environment_name}-ecs-sg"
        Environment = var.environment_name
        Team        = var.team_name
        ManagedBy   = "terraform"
    }
}

resource "aws_security_group_rule" "http" {
    description       = "allows http inbound"
    security_group_id = aws_security_group.alb.id
    type              = "ingress"
    protocol          = "tcp"
    from_port         = 80
    to_port           = 80
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https" {
    description       = "allows https inbound"
    security_group_id = aws_security_group.alb.id
    type              = "ingress"
    protocol          = "tcp"
    from_port         = 443
    to_port           = 443
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress" {
    description       = "allows egress"
    security_group_id = aws_security_group.alb.id
    type              = "egress"
    protocol          = "-1"
    from_port         = 0
    to_port           = 0
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internal" {
    description              = "allows traffic from alb to ecs"
    security_group_id        = aws_security_group.ecs.id
    type                     = "ingress"
    protocol                 = "tcp"
    from_port                = 0
    to_port                  = 65535
    source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ecs_egress" {
    description       = "allows egress"
    security_group_id = aws_security_group.ecs.id
    type              = "egress"
    protocol          = "-1"
    from_port         = 0
    to_port           = 0
    cidr_blocks       = ["0.0.0.0/0"]
}
