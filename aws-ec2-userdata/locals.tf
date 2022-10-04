locals {
  project_name = "${var.project_identifier}-${var.environment_name}"
  default_tags = {
    "Owner"       = var.owner_name
    "ManagedBy"   = "terraform"
    "Environment" = var.environment_name
    "Project"     = var.project_identifier
    "CostCenter"  = var.team_name
  }
}
