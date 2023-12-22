module "myfunction" {
  source       = "../"
  project_name = "test"
  logs_enabled = true
}

output "arn_string" {
  value = module.myfunction.arn_string
}
