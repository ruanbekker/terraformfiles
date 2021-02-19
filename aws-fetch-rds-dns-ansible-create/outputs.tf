output "db_hostname" {
    value = data.aws_db_instance.dev.address
}

output "db_user" {
    value = var.service_name
}

output "db_password" {
    value = random_password.password.result
}
