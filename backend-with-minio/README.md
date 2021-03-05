Our docker-compose for minio:

```
$ cat docker-compose.yml
version: "3.8"

services:
  minio:
    image: minio/minio
    container_name: "minio"
    volumes:
      - ./data:/data
    environment:
      - MINIO_ROOT_USER=exampleroot
      - MINIO_ROOT_PASSWORD=examplepass
    ports:
      - 9000:9000
    command: server /data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
      interval: 30s
      timeout: 20s
      retries: 3
    logging:
      driver: "json-file"
      options:
        max-size: "1m"
```

Start the minio container:

```
$ docker-compose up -d
```

Install the awscli tools:

```
$ python3 -m pip install awscli
```

Configure the minio profile:

```
$ aws --profile minio configure
AWS Access Key ID [None]: exampleroot
AWS Secret Access Key [None]: examplepass
Default region name [None]: us-east-1
Default output format [None]: json
```

You can create the bucket with terraform, but I will be using the awscli tools to test the connection:

```
$ aws --profile minio --endpoint-url http://127.0.0.1:9000 s3 mb s3://terraform-remote-state
make_bucket: terraform-remote-state
```

Initialize:

```
$ terraform init

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Installing hashicorp/aws v3.30.0...
- Installed hashicorp/aws v3.30.0 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Apply:

```
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.test will be created
  + resource "aws_s3_bucket" "test" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = "my-test-bucket"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = true
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }
    }

  # aws_s3_bucket_object.object will be created
  + resource "aws_s3_bucket_object" "object" {
      + acl                    = "private"
      + bucket                 = (known after apply)
      + content_type           = (known after apply)
      + etag                   = "eff5bc1ef8ec9d03e640fc4370f5eacd"
      + force_destroy          = false
      + id                     = (known after apply)
      + key                    = "test.txt"
      + kms_key_id             = (known after apply)
      + server_side_encryption = (known after apply)
      + source                 = "test.txt"
      + storage_class          = (known after apply)
      + version_id             = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
aws_s3_bucket.test: Creating...
aws_s3_bucket.test: Creation complete after 0s [id=my-test-bucket]
aws_s3_bucket_object.object: Creating...
aws_s3_bucket_object.object: Creation complete after 0s [id=test.txt]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

View your buckets:

```
$ aws --profile minio --endpoint-url http://127.0.0.1:9000 s3 ls /
2021-03-05 07:29:40 my-test-bucket
2021-03-05 00:44:08 terraform-remote-state
```

View the object in your created bucket:

```
$ aws --profile minio --endpoint-url http://127.0.0.1:9000 s3 ls s3://my-test-bucket/
2021-03-05 07:29:40          3 test.txt
```
