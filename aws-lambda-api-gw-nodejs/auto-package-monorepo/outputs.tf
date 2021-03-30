output "api_gw_url" {
    value = aws_api_gateway_deployment.api_deployment.invoke_url
}

output "api_gw_hello_resource" {
    value = "${aws_api_gateway_deployment.api_deployment.invoke_url}/event/hello"
}

output "api_gw_bye_resource" {
    value = "${aws_api_gateway_deployment.api_deployment.invoke_url}/event/bye"
}
