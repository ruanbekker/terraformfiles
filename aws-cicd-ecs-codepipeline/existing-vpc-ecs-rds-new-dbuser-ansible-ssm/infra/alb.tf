data "aws_security_group" "ecs_alb" {
  name        = "${var.ecs_cluster_name}-alb-sg"
  vpc_id      = data.aws_vpc.default.id 
}

resource "aws_alb_target_group" "service_tg" {
  name                 = "${var.environment_name}-${var.service_name_short}-ecs-tg"
  port                 = var.container_port
  protocol             = "HTTP"
  vpc_id               = data.aws_vpc.default.id
  target_type          = "instance"
  deregistration_delay = 10

  health_check {
    interval          = 15
    timeout           = 5
    healthy_threshold = 2
    path              = var.ecs_tg_healthcheck_endpoint
    matcher           = "200"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [ data.aws_alb.ecs ]
}

data "aws_alb" "ecs" {
  name = var.alb_name
}

data "aws_alb_listener" "https" {
  load_balancer_arn = data.aws_alb.ecs.arn
  port              = "443"
}

resource "aws_lb_listener_rule" "forward_to_tg" {
  listener_arn = data.aws_alb_listener.https.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service_tg.arn
  }

  condition {
    source_ip {
      values = [
        "0.0.0.0/0"
      ]
    }
  }

  condition {
    host_header {
      values = ["${var.service_hostname}"]
    }
  }

}
