output "ip" {
  value = libvirt_domain.domain-ubuntu.network_interface[0].addresses[0]
}
