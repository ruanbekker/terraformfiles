data "aws_acm_certificate" "wildcard" {
  domain   = var.acm_domain_name
  statuses = ["ISSUED"]
}

resource "aws_alb" "alb" {
  name            = "${var.environment_name}-${var.team_name}-alb"
  subnets         = [data.aws_subnet.public_1.id, data.aws_subnet.public_2.id, data.aws_subnet.public_3.id]
  security_groups = [aws_security_group.alb.id]
}

resource "aws_alb_listener" "http" {
    load_balancer_arn = aws_alb.alb.id
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "redirect"
        
        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_alb_listener" "https" {
    load_balancer_arn = aws_alb.alb.id
    port = "443"
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    certificate_arn = data.aws_acm_certificate.wildcard.arn

    default_action {
        type = "fixed-response"
        
        fixed_response {
            content_type = "text/plain"
            message_body = "Page not found"
            status_code  = "404"
        }
    }
}

