resource "proxmox_lxc" "ctr" {
  target_node  = "proxmox-host-1"
  hostname     = var.guest_name
  ostemplate   = "local:vztmpl/ubuntu-20.04-template-v2.tar.gz"
  password     = "password"
  console      = true
  onboot       = true
  start        = true
  unprivileged = true

  cores        = 2
  memory       = 1024

  rootfs {
    storage = "local"
    size    = "12G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr1"
    ip     = "dhcp"
    # ip   = "10.0.0.2/24"
    # gw   = "10.0.0.1"
  }

}

