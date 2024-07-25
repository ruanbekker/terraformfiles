
# Basic
resource "kubernetes_secret" "example" {
  metadata {
    name = "basic-auth"
  }

  data = {
    username = "admin"
    password = "P4ssw0rd"
  }

  type = "kubernetes.io/basic-auth"
}

# Generate Password with Random 
resource "random_password" "random_example" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "random_password" {
  type = "Opaque"

  metadata {
    name      = "random-secrets"
  }

  data = {
    password  = random_password.random_example.result
  }
}
