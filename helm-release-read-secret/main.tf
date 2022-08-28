
data "kubernetes_secret" "apitoken" {
  metadata {
    name = "basic-auth"
  }
}

resource "helm_release" "example" {
  name       = "gitlab-ci-pipelines-exporter"
  repository = "https://charts.visonneau.fr"
  chart      = "gitlab-ci-pipelines-exporter"
  version    = "0.2.17"

  values = [
    templatefile("${path.module}/templates/values.yaml.tpl", {
      api_token = data.kubernetes_secret.apitoken.data.password
    })
  ]

  set {
    name  = "image.repository"
    value = "quay.io/mvisonneau/gitlab-ci-pipelines-exporter"
  }

}
