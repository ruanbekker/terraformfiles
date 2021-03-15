## Usage

VPC Module in `./modules/networking/main.tf` and instantiation in `./main.tf`:

```
$ terraform init
$ terraform validate
$ terraform plan -var-file=./terraform.tfvars
$ terraform apply -var-file=./terraform.tfvars
```

## Credit

Much thanks to [@Prashant-jumpbyte](https://github.com/Prashant-jumpbyte/terraform-aws-vpc-setup) | [blog](https://medium.com/appgambit/terraform-aws-vpc-with-private-public-subnets-with-nat-4094ad2ab331)
