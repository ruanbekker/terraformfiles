output "endpoint" {
  value = "https://${vultr_kubernetes.this.endpoint}:6443"
}

output "client_certificate" {
  value = vultr_kubernetes.this.client_certificate
}

output "client_key" {
  value = vultr_kubernetes.this.client_key
}

output "cluster_ca_certificate" {
  value = vultr_kubernetes.this.cluster_ca_certificate
}

output "kube_config" {
  value = vultr_kubernetes.this.kube_config
}

output "kubectl_image" {
  value = "alpine/k8s:1.24.10"
}

output "installed_apps" {
  value = keys(var.enabled_apps)
  description = "List of installed apps"
}
