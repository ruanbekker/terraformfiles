resource "helm_release" "example" {
  name       = "gitlab-ci-pipelines-exporter"
  repository = "https://charts.visonneau.fr"
  chart      = "gitlab-ci-pipelines-exporter"
  version    = "0.2.17"

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name  = "image.repository"
    value = "quay.io/mvisonneau/gitlab-ci-pipelines-exporter"
  }

  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
    type  = "string"
  }
  
}
