# libvirt-ansible-nginx

Terraform example for kvm and ansible to provision a vm using the `libvirt` provisioner and install nginx using ansible via the `local-exec` provisioner.

## Pre-Requirements

You will need a KVM Host:

- [Setup KVM on Ubuntu](https://blog.ruanbekker.com/blog/2018/02/20/setup-a-kvm-hypervisor-on-ubuntu-to-host-virtual-machines/)

Install Terraform:

```
$ wget https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip
$ unzip terraform_0.13.3_linux_amd64.zip
$ sudo mv terraform /usr/local/bin/terraform
```

Install libvirt provider for Terraform:

```
$ wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.2/terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
$ tar -xvf terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
$ mkdir -p ~/.local/share/terraform/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.2/linux_amd64
$ mv ./terraform-provider-libvirt  ~/.local/share/terraform/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.2/linux_amd64/terraform-provider-libvirt
```

Install ansible:

```
$ virtualenv .venv
$ source .venv/bin/activate
$ pip install -r requirements.txt
```

## Configure

1. Configure `ssh-authorized-keys` in `config/cloud_init.yml`
2. Configure `variables.tf` and `ansible.cfg` to suite your needs
3. Ansible playbook is in `ansible/playbook.yml` and the default config is located at `ansible.cfg`

## Build

Initialize and apply:

```
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
...
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
Outputs:

ip = 192.168.122.194
url = http://192.168.122.194
```

Test:

```
$ curl -I http://192.168.122.194
HTTP/1.1 200 OK
Server: nginx/1.14.0 (Ubuntu)
Date: Sun, 27 Sep 2020 15:33:57 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Sun, 27 Sep 2020 15:33:20 GMT
Connection: keep-alive
ETag: "5f70b0c0-264"
Accept-Ranges: bytes
```

Teardown:

```
$ terraform destroy -auto-approve
```
