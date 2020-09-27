output "ip" {
  description = "The public ipv4 ip address"
  value       = aws_instance.my_instance.public_ip
}

output "url" {
  description = "The public url"
  value       = "http://${aws_instance.my_instance.public_ip}"
}
