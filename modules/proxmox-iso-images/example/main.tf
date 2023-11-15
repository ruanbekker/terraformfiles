module "proxmox_cloud_images" {
  source = "../"
  nodes  = ["pve1", "pve2", "pve3"]
}
