This provisions a ec2 instance with userdata inside a existing vpc

### Teraform Output

```
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

instance_id = i-xxxxxxxx
private_ip = 172.31.1.38
public_ip = x.x.x.x
subnet = subnet-xxxxxxx
vpc_id = vpc-xxxxxx
```

You can view the outputs as such:

```
$ terraform show -json
$ terraform output public_ip
```

### Validate Userdata

```
$ ssh -i ~/.ssh/demo.pem ubuntu@x.x.x.x
$ sudo cat /root/data.txt
This instance is in region: eu-west-1
```

