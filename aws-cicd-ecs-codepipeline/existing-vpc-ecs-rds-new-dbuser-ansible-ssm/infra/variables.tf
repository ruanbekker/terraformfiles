variable "service_name" {
  type    = string
  default = "java-hello-world"
}

variable "service_name_short" {
  type    = string
  default = "jhw"
}

variable "environment_name" {
  type    = string
  default = "dev"
}

variable "aws_account_id" {
  type    = string
}

variable "codebuild_security_group_name" {
  type    = string
  default = "vpc-codebuild" 
}

variable "codebuild_s3_appconfigs_bucket" {
  type    = string
  default = "my-app-configs-bucket"
}

variable "container_port" {
  type    = string
  default = "8080"
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
  default = "aws-ecs-cluster"
}

variable "ecs_execution_role" {
  type    = string
  default = "dev-ecs-exec-role"
}

variable "ecs_task_role" {
  type    = string
  default = "dev-ecs-task-role"
}

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "alb_name" {
  type    = string
  default = "aws-ecs-alb"
}

variable "ecs_tg_healthcheck_endpoint" {
  type    = string
  default = "/actuator/health"
}

variable "github_username" {
  type    = string
  default = "ruanbekker"
}

variable "github_repo_name" {
  type    = string
  default = "docker-java-springboot-hello-world"
}

variable "github_branch" {
  type    = string
  default = "master"
}

variable "service_hostname" {
  type    = string
  default = "helloworld.mydomain.com"
}

variable "codestarconnections_connection_arn" {
  type    = string
}

variable "codebuild_docker_image" {
  type    = string 
  default = "aws/codebuild/standard:3.0"
}

variable "codepipeline_source_stage_name" {
  type    = string 
  default = "Source"
}

variable "codepipeline_build_stage_name" {
  type    = string 
  default = "Build"
}

variable "codepipeline_deploy_stage_name" {
  type    = string 
  default = "QA"
}

variable "platform_type" {
  type       = string
  default = "ecs" 
}

variable "kms_key" {
  type    = string
  default = "devops"
}

variable "spring_datasource_username" {
  type    = string 
  default = "app"
}

