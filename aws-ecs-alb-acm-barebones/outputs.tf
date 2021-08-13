output "cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name 
}

output "cloudwatch_loggroup_name" {
  value = aws_cloudwatch_log_group.log_group.name
}

output "ecs_iam_taskrole_arn" {
  value = aws_iam_role.ecs_task_iam_role.arn
}

output "alb_dns_name" {
  value       = aws_alb.alb.dns_name
}
