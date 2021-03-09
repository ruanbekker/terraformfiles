resource "aws_api_gateway_rest_api" "test_lambda_api" {
  name = "${var.test_lambda_function_stage}-${var.lambda_function_name}"

  tags = {
    STAGE = var.test_lambda_function_stage
  }
}

resource "aws_lambda_permission" "test_lambda_api_gateway_permission" {
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"
  action = "lambda:InvokeFunction"
  source_arn = "${aws_api_gateway_rest_api.test_lambda_api.execution_arn}/*/*"

  depends_on = [aws_lambda_function.test_lambda]
}

resource "aws_api_gateway_resource" "test_api_event_resource" {
  rest_api_id = aws_api_gateway_rest_api.test_lambda_api.id
  parent_id = aws_api_gateway_rest_api.test_lambda_api.root_resource_id
  path_part = "event"
}

resource "aws_api_gateway_resource" "test_api_event_push_resource" {
  rest_api_id = aws_api_gateway_rest_api.test_lambda_api.id
  parent_id = aws_api_gateway_resource.test_api_event_resource.id
  path_part = "push"
}

resource "aws_api_gateway_method" "test_api_event_push_method" {
  rest_api_id = aws_api_gateway_rest_api.test_lambda_api.id
  resource_id = aws_api_gateway_resource.test_api_event_push_resource.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "test_api_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.test_lambda_api.id
  resource_id = aws_api_gateway_resource.test_api_event_push_resource.id
  http_method = aws_api_gateway_method.test_api_event_push_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.test_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "test_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.test_lambda_api.id
  stage_name = var.test_lambda_function_stage

  depends_on = [aws_api_gateway_integration.test_api_lambda_integration]
}

