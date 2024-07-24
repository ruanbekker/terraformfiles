# kubernetes-on-vultr


## Pre-requirements

Vultr API Key needs to be stored in `./example/terraform.tfvars` or similar methods.

### API Usage

<details>
  <summary>Example API calls to retrieve information from VULTR.</summary>

The VULTR API Documentation can be found here:
- https://www.vultr.com/api

check kubernetes versions:

```bash
curl -XGET -H "Authorization: Bearer ${VULTR_API_KEY}" "https://api.vultr.com/v2/kubernetes/versions"
```

check plans and cost:

```bash
curl -XGET -H "Authorization: Bearer ${VULTR_API_KEY}" "https://api.vultr.com/v2/plans"
```

check region:

```bash
curl -XGET -H "Authorization: Bearer ${VULTR_API_KEY}" "https://api.vultr.com/v2/regions"
```

check plans for region:

```bash
curl -XGET -H "Authorization: Bearer ${VULTR_API_KEY}" "https://api.vultr.com/v2/regions/ams/availability"
```

</details>

## Deploy the VULTR Kubernetes Cluster

Deploy the cluster:

```bash
terraform init
terraform apply
```

Set kubeconfig:

```bash
terraform output kube_config | cut -d '"' -f2 | base64 -d > /tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig
```

Access cluster:

```bash
kubectl get nodes
```

## Deploy Apps to Kubernetes

In `./example/main.tf` our module has support for deploying apps using a [`helm_release`](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) and we have 3 options:

### Option 1: No apps

This will only deploy the kubernetes cluster:

```terraform
module "kubernetes" {
  source  = "../"
  name              = "test-cluster"
  kubernetes_version = "v1.29.4+1"
}
```

### Option 2: App with default config

This option we rely on the module to provide us with default values, which can be reviewed at `./variables.tf` under `default_apps`.

```terraform
module "kubernetes" {
  source  = "../"
  name              = "test-cluster"
  kubernetes_version = "v1.29.4+1"
  enabled_apps       = {
    "nginx" = {}
  }
}
```

### Option 3: App with overrides

In this option we can provide some or all overrides, the ones that we don't provide will be defaulted from the module:

```terraform
module "kubernetes" {
  source  = "../"
  name              = "test-cluster"
  kubernetes_version = "v1.29.4+1"
  enabled_apps       = {
    "nginx" = {
      namespace  = "dev"
      values_file = "./templates/nginx.yaml"
    }
  }
}
```

## Cleanup

Destroy:

```bash
terraform destroy
```

Ensure instances are terminated:

```bash
curl -XGET -H "Authorization: Bearer ${VULTR_API_KEY}" "https://api.vultr.com/v2/instances"
```

If a instance gets stuck, you can delete it manually using:

```bash
curl -s -XDELETE -H "Authorization: Bearer ${VULTR_API_KEY}" "https://api.vultr.com/v2/instances/<instance-id>"
```
