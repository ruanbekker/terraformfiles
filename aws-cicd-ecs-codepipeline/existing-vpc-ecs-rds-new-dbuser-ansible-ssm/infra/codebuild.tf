data "aws_security_group" "codebuild" {
  name        = var.codebuild_security_group_name
  vpc_id      = data.aws_vpc.default.id 
}

data "aws_s3_bucket" "appconfigs_bucket" {
  bucket = var.codebuild_s3_appconfigs_bucket
}

data "template_file" "codebuild_policy" {
  template = "${file("templates/codebuild_iam_policy.json")}"

  vars = {
    codepipeline_bucket_arn = "${data.aws_s3_bucket.codepipeline_artifact_store.arn}"
    appconfigs_bucket_arn   = "${data.aws_s3_bucket.appconfigs_bucket.arn}"
    aws_region              = var.aws_region
    aws_account_id          = var.aws_account_id
    service_name            = var.service_name
    environment_name        = var.environment_name
    subnet_id1              = "${element(tolist(data.aws_subnet_ids.private.ids), 0)}"
    subnet_id2              = "${element(tolist(data.aws_subnet_ids.private.ids), 1)}"
    subnet_id3              = "${element(tolist(data.aws_subnet_ids.private.ids), 2)}"
  }
}

resource "aws_iam_role" "codebuild_role" {
  name               = "${var.environment_name}-${var.service_name}-codebuild-role"
  path               = "/service-role/"
  assume_role_policy = file("templates/codebuild_iam_role_policy.json")
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "${var.environment_name}-${var.service_name}-codebuild-policy"
  role   = aws_iam_role.codebuild_role.id
  policy = data.template_file.codebuild_policy.rendered
}

resource "aws_ecr_repository" "repo" {
  name = "${var.environment_name}-${var.service_name}"
}

data "template_file" "buildspec" {
  template = "${file("templates/buildspec.yml")}"

  vars = {
    container_name          = "${var.environment_name}-${var.service_name}"
    repository_url          = "${aws_ecr_repository.repo.repository_url}"
    region                  = var.aws_region
    aws_account_id          = var.aws_account_id
    appconfigs_bucket_name  = var.codebuild_s3_appconfigs_bucket
  }
}

resource "aws_codebuild_project" "build" {
  name          = "${var.service_name}-${var.environment_name}-build"
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = var.codebuild_docker_image
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  vpc_config {
    security_group_ids = [ data.aws_security_group.codebuild.id ]
    subnets            = tolist(data.aws_subnet_ids.private.ids)
    vpc_id             = data.aws_vpc.default.id
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/${var.environment_name}"
      stream_name = var.service_name
      status      = "ENABLED"
    }

    s3_logs {
      status      = "DISABLED"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.template_file.buildspec.rendered
  }
}
