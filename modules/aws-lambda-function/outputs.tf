output "arn_string" {
  value = aws_lambda_function.lambda[*].arn
}

