locals {
  debian = {
    bullseye = {
      release_version = "11"
      download_url    = "https://cdimage.debian.org/images/cloud/bullseye/20230802-1460/debian-11-generic-amd64-20230802-1460.qcow2"
      checksum_256    = "9b430d82f27be8eb2d5a37ac58bf2af52eb2605577728038f2df5bc6a697763d"
      local_filename  = "debian-11-amd64.img"
    }
    bookworm = {
      release_version = "12"
      download_url    = "https://cdimage.debian.org/images/cloud/bookworm/20230910-1499/debian-12-generic-amd64-20230910-1499.qcow2"
      checksum_256    = "39ec69d60548caacbe9d25e0ccd55d91951773041c51f443e123ccdf1822cb1c"
      local_filename  = "debian-12-amd64.img"
    }
  }
  ubuntu = {
    jammy = {
      release_version = "22.04"
      download_url    = "https://cloud-images.ubuntu.com/jammy/20230828/jammy-server-cloudimg-amd64.img"
      checksum_256    = "0bda276299fc5f189718e56f65579173475eca5ffc2263d6801b897c848b28f8"
      local_filename  = "ubuntu-jammy-amd64.img"
    }
  }
  k3sos = {
    default = {
      release_version = "0.21.5"
      download_url    = "https://github.com/rancher/k3os/releases/download/v0.21.5-k3s2r1/k3os-amd64.iso"
      checksum_256    = "a465b0c52ce415173f6ef38fda5d090580fbaae0970556a62f21c7db8eeb72b1"
      local_filename  = "k3os-amd64.iso"
    }
  }
  flatcar = {
    default = {
      release_version = "3510.2.7"
      download_url    = "https://stable.release.flatcar-linux.net/amd64-usr/3510.2.7/flatcar_production_iso_image.iso"
      checksum_256    = "d1b9ccb9ec199240269822ce73cd4e66b9583d1246a7a8582283b69d7c3cb6e1"
      local_filename  = "flatcar-amd64.iso"
    }
  }
}
