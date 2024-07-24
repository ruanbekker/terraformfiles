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

## Deploy

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
