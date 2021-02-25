data "aws_kms_alias" "kms_key" {
  name = "alias/${var.kms_key}"
}

data "aws_ssm_parameter" "rds_admin_database_username" {
  name = "/devops/${var.environment_name}/SHARED_ECS_RDS_DATABASE_USERNAME"
}

data "aws_ssm_parameter" "rds_admin_database_password" {
  name = "/devops/${var.environment_name}/SHARED_ECS_RDS_DATABASE_PASSWORD"
}

resource "aws_ssm_parameter" "database_host" {
  name  = "/${var.service_name}/${var.environment_name}/DB_HOST"
  type  = "String"
  value = data.aws_db_instance.qa.address
}

resource "aws_ssm_parameter" "database_port" {
  name  = "/${var.service_name}/${var.environment_name}/DB_PORT"
  type  = "String"
  value = data.aws_db_instance.qa.port
}

resource "aws_ssm_parameter" "database_password" {
  name   = "/${var.service_name}/${var.environment_name}/DB_PASSWORD"
  type   = "SecureString"
  key_id = data.aws_kms_alias.kms_key.target_key_id 
  value  = random_password.db_password.result
}

resource "aws_ssm_parameter" "database_name" {
  name  = "/${var.service_name}/${var.environment_name}/DB_NAME"
  type  = "String"
  value = var.service_name_short
}

resource "aws_ssm_parameter" "database_user" {
  name  = "/${var.service_name}/${var.environment_name}/DB_USER"
  type  = "String"
  value = var.service_name_short
}

resource "aws_ssm_parameter" "spring_datasource_url" {
  name  = "/${var.service_name}/${var.environment_name}/SPRING_DATASOURCE_URL"
  type  = "String"
  value = "jdbc:mariadb://${data.aws_db_instance.qa.address}:${data.aws_db_instance.qa.port}/card?characterEncoding=utf8"
}

resource "aws_ssm_parameter" "spring_datasource_username" {
  name  = "/${var.service_name}/${var.environment_name}/SPRING_DATASOURCE_USERNAME"
  type  = "String"
  value = var.spring_datasource_username
}

resource "aws_ssm_parameter" "spring_datasource_password" {
  name  = "/${var.service_name}/${var.environment_name}/SPRING_DATASOURCE_PASSWORD"
  type   = "SecureString"
  key_id = data.aws_kms_alias.kms_key.target_key_id 
  value = random_password.db_password.result
}

resource "aws_ssm_parameter" "sqs_queue_one_name" {
  name  = "/${var.service_name}/${var.environment_name}/SQS_ONE_QUEUE_NAME"
  type  = "String"
  value = data.aws_sqs_queue.one.name
}

resource "aws_ssm_parameter" "sqs_queue_one_endpoint_uri" {
  name  = "/${var.service_name}/${var.environment_name}/SQS_ONE_QUEUE_ENDPOINT_URI"
  type  = "String"
  value = data.aws_sqs_queue.one.url
}

