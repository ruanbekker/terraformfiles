If you are using workspaces you can include your workspace name in your resources:

```
resource "aws_s3_bucket" "this" {
  bucket = "ruanbekker.${terraform.workspace}.dummybucket"
}
```

After you ran `terraform init` you can do:

```
$ terraform workspace new dev
$ terraform workspace list
$ terraform workspace select dev
$ terraform apply

Outputs:
s3_bucket = "arn:aws:s3:::ruanbekker.dev.dummybucket"
```

The key on s3 will then look like this:

```
$ aws --profile rbkr-master s3 ls --recursive s3://my-terraform-remote-state/env:/dev/
2021-02-28 01:09:05       3097 env:/dev/test/terraform.tfstate
```

If our `backend.tf` looks like this:

```
terraform {
  backend "s3" {
    bucket = "my-terraform-remote-state"
    key = "test/terraform.tfstate"
    ...
  }
}
```
