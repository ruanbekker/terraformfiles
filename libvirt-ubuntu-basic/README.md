# Terraform with KVM example

Install terraform:

```
$ wget https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip
$ unzip terraform_0.13.3_linux_amd64.zip
$ sudo mv terraform /usr/local/bin/terraform
```

Install libvirt provider:

```
$ wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.2/terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
$ tar -xvf terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
$ mkdir -p ~/.local/share/terraform/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.2/linux_amd64
$ mv ./terraform-provider-libvirt  ~/.local/share/terraform/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.2/linux_amd64/terraform-provider-libvirt
```

Change to the `libvirt-ubuntu-basic` directory, change the `libvirt_disk_path` in `variables.tf` to the path where you want your storage to be located, then run:

```
$ terraform init
$ terraform plan
$ terraform apply
```
