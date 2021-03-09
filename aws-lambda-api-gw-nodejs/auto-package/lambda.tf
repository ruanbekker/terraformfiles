data "archive_file" "test_lambda_package" {
  type = "zip"
  source_file = "${path.module}/files/index.js"
  output_path = var.lambda_function_zip_name
}

data "aws_iam_policy_document" "test_lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "test_lambda_role" {
  name = "${var.lambda_function_name}-${var.test_lambda_function_stage}-eu-west-1-lambdaRole"
  assume_role_policy = data.aws_iam_policy_document.test_lambda_assume_role_policy.json
}

resource "aws_cloudwatch_log_group" "test_lambda_logging" {
  name = "/aws/lambda/${var.lambda_function_name}-${var.test_lambda_function_stage}"
}

data "aws_iam_policy_document" "cloudwatch_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]
    resources = [aws_cloudwatch_log_group.test_lambda_logging.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.test_lambda_logging.arn}:*"]
  }
}

resource "aws_iam_role_policy" "test_lambda_cloudwatch_policy" {
  name = "${var.lambda_function_name}-${var.test_lambda_function_stage}-cloudwatch-policy"
  policy = data.aws_iam_policy_document.cloudwatch_role_policy_document.json
  role = aws_iam_role.test_lambda_role.id
}

resource "aws_lambda_function" "test_lambda" {
  function_name = var.lambda_function_name
  filename = var.lambda_function_zip_name
  source_code_hash = data.archive_file.test_lambda_package.output_base64sha256
  handler = var.lambda_handler
  runtime = var.lambda_runtime
  publish = "true"
  layers = [aws_lambda_layer_version.test_lambda_nodejs_layer.arn]
  role = aws_iam_role.test_lambda_role.arn
}
