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
   default = "workers-demo"
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

variable "stage" {
   type    = string
   default = "prod"
}

variable "base_cidr_block" {
   type    = string
   default = "172.31.0.0"
}

variable "log_group_name" {
   type    = string
   default = "/ecs/ecs/prod-workers"
}

variable "image_version" {
   type    = string
   default = "latest"
}

variable "ecr_image_retention_in_count" {
  type        = number
  default     = 7
  description = "the number of images to keep"
}

variable "private_network_tier" {
   type    = string
   default = "private"
}

variable "public_network_tier" {
   type    = string
   default = "public"
}

variable "elasticache_private_subnet_group_name" {
  type        = string
  default     = "private-subnets"
  description = "the name of the private subnet group"
}
