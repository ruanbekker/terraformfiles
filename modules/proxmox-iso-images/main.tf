# source: https://cdimage.debian.org/images/cloud/bullseye/

resource "proxmox_virtual_environment_file" "debian_11" {
  for_each     = toset(var.nodes)
  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value

  source_file {
    path      = local.debian.bullseye.download_url
    file_name = local.debian.bullseye.local_filename
    checksum  = local.debian.bullseye.checksum_256
  }
}

resource "proxmox_virtual_environment_file" "debian_12" {
  for_each     = toset(var.nodes)
  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value

  source_file {
    path      = local.debian.bookworm.download_url
    file_name = local.debian.bookworm.local_filename
    checksum  = local.debian.bookworm.checksum_256
  }
}

# source: https://cloud-images.ubuntu.com/

resource "proxmox_virtual_environment_file" "ubuntu_jammy" {
  for_each     = toset(var.nodes)
  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value

  source_file {
    path      = local.ubuntu.jammy.download_url
    file_name = local.ubuntu.jammy.local_filename
    checksum  = local.ubuntu.jammy.checksum_256
  }
}

# source: https://github.com/rancher/k3os/releases

resource "proxmox_virtual_environment_file" "k3os" {
  for_each     = toset(var.nodes)
  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value

  source_file {
    path      = local.k3sos.default.download_url
    file_name = local.k3sos.default.local_filename
    checksum  = local.k3sos.default.checksum_256
  }
}

# source: https://stable.release.flatcar-linux.net/amd64-usr/

resource "proxmox_virtual_environment_file" "flatcar" {
  for_each     = toset(var.nodes)
  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value

  source_file {
    path      = local.flatcar.default.download_url
    file_name = local.flatcar.default.local_filename
    checksum  = local.flatcar.default.checksum_256
  }
}

