resource "hcloud_firewall" "fw" {
  name = "my-fw"

  rule {
    description     = "ICMP"
    direction       = "in"
    protocol        = "icmp"
    source_ips      = [
      "0.0.0.0/0",
      "::/0",
    ]
    description = "Ping"
  }

  rule {
    description     = "SSH"
    direction       = "in"
    port            = "22"
    protocol        = "tcp"
    source_ips      = [
      "0.0.0.0/0",
      "::/0",
    ]
    description = "SSH"
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "any"
    source_ips = [
      "172.31.37.10/32"
    ]
    description = "Bastion"
  }

}
