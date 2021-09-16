data "aws_ecs_cluster" "dev" {
  cluster_name = var.ecs_cluster_name
}
