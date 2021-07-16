output "ip" {
  description = "The private ipv4 ip address"
  value       = aws_instance.my_instance.private_ip
}

output "az" {
  value = random_shuffle.az.result[0]
}

output "subnet" {
  value = data.aws_subnet.private.id
}
