# variables via cli

Example to demonstrate how to pass environment variable values via the cli. 

The variable is defined in `variables.tf` and referenced in `main.tf`, as no value is defined, we are setting the value at runtime:

```
$ terraform init
$ terraform apply -var 'owner=ruan' -auto-approve

null_resource.this: Creating...
null_resource.this: Provisioning with 'local-exec'...
null_resource.this (local-exec): Executing: ["/bin/sh" "-c" "echo ruan > file_4397943546484635522.txt"]
null_resource.this: Creation complete after 0s [id=4397943546484635522]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

View the written file:

```
$ cat file_4397943546484635522.txt
ruan
```
