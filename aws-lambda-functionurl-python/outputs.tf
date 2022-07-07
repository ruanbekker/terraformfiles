output "function_arn" {
  value = aws_lambda_function.webhook_function.arn
}

output "function_invoke_arn" {
  value = aws_lambda_function.webhook_function.invoke_arn
}

output "function_url" {
  value = aws_lambda_function_url.webhook_function.function_url
}

