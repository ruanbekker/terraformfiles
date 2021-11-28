# Backend with Environment Variables

State `state.tf`:

```
terraform {
  backend "s3" {
  }
}
```

The `terraform.tfvars`:

```
region=us-east-1
application=foo
environment=bar
```

The init command:

```
terraform init \
  -backend-config access_key=$AWS_ACCESS_KEY_ID \
  -backend-config secret_key=$AWS_SECRET_ACCESS_KEY \
  -backend-config "region=$TF_VAR_region" \
  -backend-config "bucket=terraform-remote-state" \
  -backend-config "key=$TF_VAR_application/$TF_VAR_environment" \
  -backend-config "endpoint=$MINIO_ENDPOINT" \
  -backend-config "force_path_style=true" \
  -backend-config "skip_credentials_validation=true" \
  -backend-config "skip_metadata_api_check=true" \
  -backend-config "skip_region_validation=true"
```

