variable "nodes" {
  type        = list(string)
  description = "List of proxmox nodes."
  default     = ["pve1", "pve2", "pve3"]

  validation {
    condition     = alltrue([for node in var.nodes : can(regex("^pve", node))])
    error_message = "All node names must start with 'pve'."
  }

}
