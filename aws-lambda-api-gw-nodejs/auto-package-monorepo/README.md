# monorepo-lambda-app-poc
Monorepo POC with AWS Lambda and Terraform

## Pre-Requisites

```
- terraform
- npm
```
## About

This example will build a API with 2 Lambda Integrations:

- `POST /event/hello`
- `POST /event/bye`

The lambda's structure:

```
$ tree .
.
├── functions
│   ├── bye-greeting
│   │   └── index.js
│   └── hello-greeting
│       └── index.js
```

In this case each lambda may have different dependencies, to to simplify things, I am using the `package.json` under `layers/commonlibs/nodejs/package.json` to specify all the dependencies that needs to be present in the lambda container runtime, and create a commonlibs lambda layer and let each lambda use that layer.

Because this will be deployed by a deployment pipeline, the created packages which is shipped to Lambda wont be present each time, therefore using the `source_code_hash` option in both the `aws_lambda` and `aws_lambda_layer_version` resources, so that the hash of those files can be stored in terraform-state, so if the hash gets calculated and they remain the same as in state, then it means nothing changed and no deploy is needed.

As example:

```
$ rm -rf ./hello-package.zip ./bye-package.zip ./build/commonlibs.zip
$ terraform apply
...
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```
