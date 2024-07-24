output "endpoint" {
  value = "https://${vultr_kubernetes.k8.endpoint}:6443"
}

output "client_certificate" {
  value = vultr_kubernetes.k8.client_certificate
}

output "client_key" {
  value = vultr_kubernetes.k8.client_key
}

output "cluster_ca_certificate" {
  value = vultr_kubernetes.k8.cluster_ca_certificate
}

output "kube_config" {
  value = vultr_kubernetes.k8.kube_config
}

output "kubectl_image" {
  value = "alpine/k8s:1.24.10"
}

output "installed_apps" {
  value = keys(var.enabled_apps)
  description = "List of installed apps"
}
