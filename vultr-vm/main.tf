data "vultr_os" "ubuntu" {
  filter {
    name   = "name"
    values = [var.ubuntu_20]
  }
}

data "vultr_ssh_key" "my_ssh_key" {
  filter {
    name = "name"
    values = [var.ssh_key_name]
  }
}

data "vultr_startup_script" "docker" {
  filter {
    name = "name"
    values = [var.startup_script_name]
  }
}

resource "vultr_instance" "eph" {
    plan = "vc2-1c-1gb"
    region = "ams"
    os_id = data.vultr_os.ubuntu.id
    ssh_key_ids = [data.vultr_ssh_key.my_ssh_key.id]
    label = var.instance_name
    tag = var.instance_name
    hostname = var.instance_name
    script_id = data.vultr_startup_script.docker.id
    enable_ipv6 = false
    backups = "disabled"
    ddos_protection = false
    activation_email = false
}
