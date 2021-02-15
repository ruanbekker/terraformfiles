variable "service_name" {
  type    = string
  default = "my-web-service"
}

variable "environment_name" {
  type    = string
  default = "dev"
}

variable "aws_account_id" {
  type    = string
  default = ""
}

variable "codebuild_security_group_name" {
  type    = string
  default = "vpc-codebuild"
}

variable "kms_key" {
  type    = string
  default = ""
}

variable "container_port" {
  type    = string
  default = "5000"
}

variable "host_port" {
  type    = string
  default = "0"
}

variable "container_desired_count" {
  type    = string
  default = "1"
}

variable "container_desired_cpu" {
  type    = string
  default = "256"
}

variable "container_desired_memory" {
  type    = string
  default = "256"
}

variable "container_reserved_task_memory" {
  type    = string
  default = "128"
}

variable "ecs_cluster_name" {
  type    = string
  default = "my-ecs-cluster"
}

variable "ecs_execution_role" {
  type    = string
  default = "ecs-execution-role"
}

variable "ecs_task_role" {
  type    = string
  default = "ecs-task-role"
}

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "alb_name" {
  type    = string
  default = "my-ecs-alb"
}

variable "github_username" {
  type    = string
  default = ""
}

variable "github_repo_name" {
  type    = string
  default = ""
}

variable "github_branch" {
  type    = string
  default = "main"
}

variable "service_hostname" {
  type    = string
  default = "my-web-service.mydomain.com"
}

# unable to use codestarconnections data source
# https://github.com/hashicorp/terraform-provider-aws/issues/15453
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection
variable "codestarconnections_connection_arn" {
  type    = string
  default = ""
}
