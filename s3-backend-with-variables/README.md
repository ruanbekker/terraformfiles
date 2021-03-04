Variables isn't supported for backend, see [this issue](https://github.com/hashicorp/terraform/issues/13022#issuecomment-294262392), to use variables, you can inspect `initialize.sh` or do the following:

```
$ terraform init -backend=true \
  -backend-config "bucket=$TF_VAR_tf_state_bucket" \
  -backend-config "key=TF_VAR_service_name/$TF_VAR_environment_name/$TF_VAR_platform_type/terraform.tfstate" \
  -backend-config "dynamodb_table=$TF_VAR_dynamodb_state_table" \
  -backend-config "profile=$TF_VAR_aws_profile" \
  -backend-config "region=$TF_VAR_aws_region" \
  -backend-config "shared_credentials_file=~/.aws/credentials"

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Installing hashicorp/aws v3.30.0...
- Installed hashicorp/aws v3.30.0 (signed by HashiCorp)

Terraform has been successfully initialized!
```

Apply:

```
terraform apply
Acquiring state lock. This may take a few moments...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:

Terraform will perform the following actions:

Plan: 0 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  + policy_arn2 = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
Releasing state lock. This may take a few moments...

Outputs:

policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
policy_arn2 = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
```

Delete the `.terraform` directory:

```
$ rm -rf .terraform
```

Initialize again:

```
$ terraform init -backend=true \
  -backend-config "bucket=$TF_VAR_tf_state_bucket" \
  -backend-config "key=TF_VAR_service_name/$TF_VAR_environment_name/$TF_VAR_platform_type/terraform.tfstate" \
  -backend-config "dynamodb_table=$TF_VAR_dynamodb_state_table" \
  -backend-config "profile=$TF_VAR_aws_profile" \
  -backend-config "region=$TF_VAR_aws_region" \
  -backend-config "shared_credentials_file=~/.aws/credentials"
```

Show the output to see if the state was persisted on s3:

```
$ terraform output -json
{
  "policy_arn": {
    "sensitive": false,
    "type": "string",
    "value": "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  },
  "policy_arn2": {
    "sensitive": false,
    "type": "string",
    "value": "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  }
}
```
