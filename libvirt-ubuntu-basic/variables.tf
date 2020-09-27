variable "libvirt_disk_path" {
    description = "path for libvirt pool"
    default     = "/disk1/vms/disks/pool1"
}

variable "ubuntu_18_img_url" {
    description = "ubuntu 18.04 image"
    default     = "http://cloud-images.ubuntu.com/releases/bionic/release-20191008/ubuntu-18.04-server-cloudimg-amd64.img"
}
