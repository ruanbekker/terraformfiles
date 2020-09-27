# Terraform with Delay 

Using the null resource we can demonstrate a delay after resource creation and deletion using [sleep](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep).

```
$ terraform init
$ terraform apply -auto-approve
$ terraform destroy -auto-approve
```

Resource:
- https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep
