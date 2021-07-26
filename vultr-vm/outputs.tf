output "os_id" {
  value = data.vultr_os.ubuntu.id
}

output "instance_id" {
  value = vultr_instance.eph.id
}

output "instance_hostname" {
  value = vultr_instance.eph.hostname
}

output "instance_ip" {
  value = vultr_instance.eph.main_ip
}

output "instance_os" {
  value = vultr_instance.eph.os
}

output "ssh_string" {
  value = "ssh -i ~/.ssh/${var.ssh_key_name}.pem root@${vultr_instance.eph.main_ip}"
}
