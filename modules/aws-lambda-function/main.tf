data "aws_iam_policy_document" "lambda" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_execution" {
  count = var.logs_enabled ? 1 : 0

  statement {
    sid     = "GetCallerIdentity"
    effect  = "Allow"

    actions = [
      "sts:GetCallerIdentity"
    ]

    resources = ["*"]

  }

  statement {
    sid     = "DescribeFunctionsInRegion"
    effect  = "Allow"

    actions = [
      "lambda:GetFunction"
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [var.aws_region]
    }
  }

}

resource "aws_iam_role_policy" "lambda_execution_policy" {
  count  = var.logs_enabled ? 1 : 0
  name   = "${var.project_name}-lambda-function-execution-policy"
  role   = aws_iam_role.lambda_role[count.index].id
  policy = data.aws_iam_policy_document.lambda_execution[count.index].json
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/functions/demo.py"
  output_path = "${path.module}/lambda-archives/package.zip"
}

resource "aws_iam_role" "lambda_role" {
  count              = var.logs_enabled ? 1 : 0
  name               = "${var.project_name}-lambda-function-role"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_lambda_function" "lambda" {
  count            = var.logs_enabled ? 1 : 0
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${var.project_name}-lambda-function"
  role             = aws_iam_role.lambda_role[count.index].arn
  handler          = "demo.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  runtime          = "python3.8"
  timeout          = 30

  environment {
    variables = {
      PROJECT_NAME  = var.project_name
      FUNCTION_NAME = "${var.project_name}-lambda-function"
    }
  }

  depends_on = [
    data.archive_file.lambda_zip
  ]

}

resource "aws_cloudwatch_event_rule" "every_two_hours" {
  count               = var.logs_enabled ? 1 : 0
  name                = "${var.project_name}-every-two-hours"
  description         = "Fires every 2 hours"
  schedule_expression = "rate(2 hours)"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  count         = var.logs_enabled ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda[count.index].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_two_hours[count.index].arn
}

resource "aws_cloudwatch_event_target" "cloudwatch_event" {
  count     = var.logs_enabled ? 1 : 0
  rule      = aws_cloudwatch_event_rule.every_two_hours[count.index].name
  target_id = "${var.project_name}-snapshot-retention-target"
  arn       = aws_lambda_function.lambda[count.index].arn
}

// CloudWatch Logs
resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  count     = var.logs_enabled ? 1 : 0
  name      = "/aws/lambda/${aws_lambda_function.lambda[count.index].function_name}"
  retention_in_days = 5
}

resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  count      = var.logs_enabled ? 1 : 0
  role       = aws_iam_role.lambda_role[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

