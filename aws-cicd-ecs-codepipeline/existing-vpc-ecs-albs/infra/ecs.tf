data "aws_ecs_cluster" "qa_payout" {
  cluster_name = var.ecs_cluster_name
}
