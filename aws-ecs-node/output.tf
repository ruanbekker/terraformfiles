output "private_ip" {
    description = "private ip"
    value       = aws_instance.ec2.private_ip
}

output "instance_id" {
    description = "instance id"
    value       = aws_instance.ec2.id
}

output "ami_id" {
    value       = data.aws_ami.latest_ecs.id
}