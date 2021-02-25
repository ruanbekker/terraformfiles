data "aws_s3_bucket" "codepipeline_artifact_store" {
  bucket        = "codepipeline-${var.environment_name}-${var.aws_account_id}"
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "${var.service_name}-${var.environment_name}-codepipeline-role"
  path               = "/service-role/"
  assume_role_policy = file("templates/codepipeline_iam_role_policy.json")
}

data "template_file" "codepipeline_policy" {
  template = file("templates/codepipeline_iam_policy.json")

  vars = {
    codepipeline_bucket_arn = data.aws_s3_bucket.codepipeline_artifact_store.arn
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "${var.service_name}-${var.environment_name}-codepipeline_policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.template_file.codepipeline_policy.rendered
}

resource "aws_codepipeline" "pipeline" {
  name     = "${var.service_name}-${var.environment_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = data.aws_s3_bucket.codepipeline_artifact_store.bucket
    type     = "S3"
  }

  stage {
    name = var.codepipeline_source_stage_name

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        ConnectionArn    = var.codestarconnections_connection_arn
        FullRepositoryId = "${var.github_username}/${var.github_repo_name}"
        BranchName       = var.github_branch
      }
    }
  }

  stage {
    name = var.codepipeline_build_stage_name

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source"]
      output_artifacts = ["imagedefinitions"]

      configuration = {
        ProjectName = "${var.service_name}-${var.environment_name}-build"
      }
    }
  }

  stage {
    name = var.codepipeline_deploy_stage_name

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["imagedefinitions"]
      version         = "1"

      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = "${var.environment_name}-${var.service_name}"
        FileName    = "imagedefinitions.json"
      }
    }
  }
}

