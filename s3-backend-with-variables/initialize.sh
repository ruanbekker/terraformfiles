#!/usr/bin/env bash

TF_VAR_tf_state_bucket=""
TF_VAR_service_name=""
TF_VAR_platform_type=""
TF_VAR_environment_name=""
TF_VAR_platform_type=""
TF_VAR_dynamodb_state_table=""
TF_VAR_aws_profile=""
TF_VAR_aws_region=""

terraform init -backend=true \
  -backend-config "bucket=$TF_VAR_tf_state_bucket" \
  -backend-config "key=TF_VAR_service_name/$TF_VAR_environment_name/$TF_VAR_platform_type/terraform.tfstate" \
  -backend-config "dynamodb_table=$TF_VAR_dynamodb_state_table" \
  -backend-config "profile=$TF_VAR_aws_profile" \
  -backend-config "region=$TF_VAR_aws_region" \
  -backend-config "shared_credentials_file=~/.aws/credentials"
