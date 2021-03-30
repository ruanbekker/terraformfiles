resource "aws_api_gateway_rest_api" "lambda_api" {
  name = "${var.lambda_function_stage}-${var.application_name}"

  tags = {
    STAGE = var.lambda_function_stage
  }
}

resource "aws_lambda_permission" "hello_lambda_api_gateway_permission" {
  function_name = "${var.application_name}-hello"
  principal = "apigateway.amazonaws.com"
  action = "lambda:InvokeFunction"
  source_arn = "${aws_api_gateway_rest_api.lambda_api.execution_arn}/*/*"

  depends_on = [aws_lambda_function.hello_lambda]
}

resource "aws_lambda_permission" "bye_lambda_api_gateway_permission" {
  function_name = "${var.application_name}-bye"
  principal = "apigateway.amazonaws.com"
  action = "lambda:InvokeFunction"
  source_arn = "${aws_api_gateway_rest_api.lambda_api.execution_arn}/*/*"

  depends_on = [aws_lambda_function.bye_lambda]
}

resource "aws_api_gateway_resource" "api_event_resource" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id = aws_api_gateway_rest_api.lambda_api.root_resource_id
  path_part = "event"
}

resource "aws_api_gateway_resource" "api_event_hello_resource" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id = aws_api_gateway_resource.api_event_resource.id
  path_part = "hello"
}

resource "aws_api_gateway_resource" "api_event_bye_resource" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id = aws_api_gateway_resource.api_event_resource.id
  path_part = "bye"
}

resource "aws_api_gateway_method" "api_event_hello_method" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.api_event_hello_resource.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "api_event_bye_method" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.api_event_bye_resource.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "hello_api_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.api_event_hello_resource.id
  http_method = aws_api_gateway_method.api_event_hello_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.hello_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "bye_api_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.api_event_bye_resource.id
  http_method = aws_api_gateway_method.api_event_bye_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.bye_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  stage_name = var.lambda_function_stage

  depends_on = [
    aws_api_gateway_integration.hello_api_lambda_integration,
    aws_api_gateway_integration.bye_api_lambda_integration
  ]
}
