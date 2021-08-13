variable "aws_region" {
   type    = string
   default = "eu-west-1"
}

variable "public_network_tier" {
  type        = string
  default     = "public"
  description = "used for public networking"
}

variable "private_network_tier" {
  type        = string
  default     = "private"
  description = "used for private networking"
}

variable "environment_name" {
   type    = string
   default = "production"
}

variable "team_name" {
  type        = string
  default     = "devops"
  description = "team name responsible for project"
}

variable "log_group_name" {
  type        = string
  default     = "/ecs/devops"
  description = "log group for ecs cluster"
}

variable "project_name" {
   type    = string
   default = ""
}

variable "tag_purpose" {
   type    = string
   default = ""
}

variable "tag_owner" {
   type    = string
   default = ""
}

variable "tag_managedby" {
   type    = string
   default = "terraform"
}
