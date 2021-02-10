output "vpc_id" {
    description = "The Default VPC ID"
    value       = data.aws_vpc.default.id
}

output "subnet" {
    description = "subnet"
    value       = element("${random_shuffle.subnets.result}", 1)
}

output "public_ip" {
    description = "public ip"
    value       = "${aws_instance.ec2.public_ip}"
}

output "private_ip" {
    description = "private ip"
    value       = "${aws_instance.ec2.private_ip}"
}

output "instance_id" {
    description = "instance id"
    value       = "${aws_instance.ec2.id}"
}
