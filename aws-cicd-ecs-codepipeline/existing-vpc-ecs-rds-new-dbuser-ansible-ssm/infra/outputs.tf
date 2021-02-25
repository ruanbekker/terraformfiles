output "environment_name" {
  value = var.environment_name
}

output "alb_dns" {
  value = data.aws_alb.ecs.dns_name
}

output "service_hostname" {
  value = var.service_hostname
}

output "sqs_response_url" {
  value = data.aws_sqs_queue.response.url
}

output "sqs_sms_url" {
  value = data.aws_sqs_queue.sms.url
}

output "db_address" {
    value = data.aws_db_instance.qa.address
}
