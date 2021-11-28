variable "aws_region" {
   type    = string
   default = "eu-west-1"
}

variable "team_name" {
  type    = string
  default = "devops"
}

variable "project_name" {
   type    = string
   default = "efs-demo"
}

variable "environment_name" {
   type    = string
   default = "prod"
}

variable "ecs_cluster_name" {
  type        = string
  default     = "ecs-cluster"
}

variable "alb_name" {
  type        = string
  default     = "ecs-alb"
}

variable "alb_sg_name" {
  type        = string
  default     = "ecs-alb-sg"
}

variable "log_group_name" {
  type        = string
  default     = "ecs-logs"
}

