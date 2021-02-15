output "environment_name" {
  value = var.environment_name
}

output "alb_dns" {
  value = data.aws_alb.ecs.dns_name
}

output "service_hostname" {
  value = var.service_hostname
}
