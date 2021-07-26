variable "ubuntu_20" {
  type    = string
  default = "Ubuntu 20.04 x64"
}

variable "debian_10" {
  type    = string
  default = "Debian 10 x64 (buster)"
}

variable "ssh_key_name" {
  type    = string
  default = "vultr"
}

variable "startup_script_name" {
  type    = string
  default = "docker"
}

variable "instance_name" {
  type    = string
  default = "eph-instance"
}
