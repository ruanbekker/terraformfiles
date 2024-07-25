terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "kubernetes" {
  host = "https://172.20.185.188:6443"
  client_certificate     = base64decode(file("certs/client-cert.pem"))
  client_key             = base64decode(file("certs/client-key.pem"))
  cluster_ca_certificate = base64decode(file("certs/cluster-ca-cert.pem"))
}

provider "random" {}

