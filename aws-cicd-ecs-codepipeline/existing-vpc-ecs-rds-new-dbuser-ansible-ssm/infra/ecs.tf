data "aws_ecs_cluster" "qa" {
  cluster_name = var.ecs_cluster_name
}
