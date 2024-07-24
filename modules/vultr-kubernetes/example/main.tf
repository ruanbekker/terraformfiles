data "kubernetes_all_namespaces" "allns" {
  depends_on = [
    module.kubernetes.endpoint
  ]
}

module "kubernetes" {
  source  = "../"
  name              = "test-cluster"
  kubernetes_version = "v1.29.4+1"
  enabled_apps       = {
    "nginx" = {
      namespace  = "dev"
      values_file = "./templates/nginx.yaml"
    }
  }
}

