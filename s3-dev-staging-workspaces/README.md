# workspaces with multi envs

Use terraform workspaces for multi environments

## Usage

Initialize:

```bash
$ terraform init
```

Create a dev workspace and apply:

```bash
$ terraform workspace new dev
$ terraform apply -var bucket_name=ruanbekker-test -auto-approve

Outputs:
s3_bucket_arn = "arn:aws:s3:::dev-ruanbekker-test"
```

Create a staging workspace and apply:

```bash
$ terraform workspace new staging
$ terraform apply -var bucket_name=ruanbekker-test -auto-approve

Outputs:
s3_bucket_arn = "arn:aws:s3:::staging-ruanbekker-test"
```

List your workspaces:

```bash
$ terraform workspace list
  default
* dev
  staging
```

Show your selected workspace:

```bash
$ terraform workspace show
dev
```

Select a new workspace:

```bash
$ terraform workspace select staging
```

Destroy the resources for that workspace/environment:

```bash
$ terraform destroy -var bucket_name=ruanbekker-test
```
