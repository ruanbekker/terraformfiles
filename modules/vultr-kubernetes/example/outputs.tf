output "endpoint" {
  value = module.kubernetes.endpoint
}

output "kube_config" {
  value = module.kubernetes.kube_config
  sensitive = true
}

output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}

output "installed_apps" {
  value = module.kubernetes.installed_apps
  description = "List of apps that have been installed"
}
