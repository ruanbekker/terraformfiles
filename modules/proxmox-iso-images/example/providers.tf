terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.30.3"
    }
  }
  required_version = "~> 1.5.0"
}

provider "random" {}

provider "proxmox" {
  endpoint = "https://${var.proxmox_ip_address}:8006/"
  insecure = true
  username = var.proxmox_username
  password = var.proxmox_password
}

