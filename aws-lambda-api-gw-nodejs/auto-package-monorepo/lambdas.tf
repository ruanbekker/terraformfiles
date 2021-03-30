data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.application_name}-${var.lambda_function_stage}-eu-west-1-lambdaRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_cloudwatch_log_group" "lambda_logging" {
  name = "/aws/lambda/mono-repo-${var.application_name}-${var.lambda_function_stage}"
}

data "aws_iam_policy_document" "cloudwatch_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]
    resources = [aws_cloudwatch_log_group.lambda_logging.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.lambda_logging.arn}:*"]
  }
}

resource "aws_iam_role_policy" "lambda_cloudwatch_policy" {
  name = "${var.application_name}-${var.lambda_function_stage}-cloudwatch-policy"
  policy = data.aws_iam_policy_document.cloudwatch_role_policy_document.json
  role = aws_iam_role.lambda_role.id
}

data "archive_file" "hello_lambda_package" {
  type = "zip"
  source_file = "${path.module}/functions/hello-greeting/index.js"
  output_path = "hello-${var.lambda_function_zip_name}"
}

data "archive_file" "bye_lambda_package" {
  type = "zip"
  source_file = "${path.module}/functions/bye-greeting/index.js"
  output_path = "bye-${var.lambda_function_zip_name}"
}

resource "aws_lambda_function" "hello_lambda" {
  function_name = "${var.application_name}-hello"
  filename = "hello-${var.lambda_function_zip_name}"
  source_code_hash = data.archive_file.hello_lambda_package.output_base64sha256
  handler = var.lambda_handler
  runtime = var.lambda_runtime
  publish = "true"
  layers = [aws_lambda_layer_version.common_nodejs_layer.arn]
  role = aws_iam_role.lambda_role.arn
}

resource "aws_lambda_function" "bye_lambda" {
  function_name = "${var.application_name}-bye"
  filename = "bye-${var.lambda_function_zip_name}"
  source_code_hash = data.archive_file.bye_lambda_package.output_base64sha256
  handler = var.lambda_handler
  runtime = var.lambda_runtime
  publish = "true"
  layers = [aws_lambda_layer_version.common_nodejs_layer.arn]
  role = aws_iam_role.lambda_role.arn
}
