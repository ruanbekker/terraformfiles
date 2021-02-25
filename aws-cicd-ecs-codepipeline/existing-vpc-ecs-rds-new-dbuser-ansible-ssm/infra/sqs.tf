resource "aws_sqs_queue" "one" {
  name = "${var.environment_name}-${var.service_name_short}-one-queue"
  tags = {
    "Name"        = "${var.environment_name}-${var.service_name_short}-one-queue"
    "Environment" = var.environment_name
  }
}

data "aws_sqs_queue" "one" {
  name = "${var.environment_name}-${var.service_name_short}-one-queue"
}

