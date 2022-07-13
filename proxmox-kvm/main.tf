resource "proxmox_vm_qemu" "vm" {
  name        = var.vm_name
  desc        = "ubuntu server with terraform"
  target_node = "proxmox-host-1"

  onboot      = true
  agent       = 1

  clone       = "focal-cloudimg-v1"
  full_clone  = false

  cores       = 2
  sockets     = 1
  cpu         = "host"
  memory      = 2048

  network {
    bridge = "vmbr1"
    model  = "virtio"
  }

  disk {
    storage = "local"
    type    = "scsi"
    size    = "20G"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp"
  ciuser     = "ubuntu"
  cipassword = "password"
  sshkeys = <<EOF
  ssh-rsa xxxxx proxmox-guest-key
  EOF

}

output "ipv4" {
  value = proxmox_vm_qemu.vm.default_ipv4_address
}
