variable "name" {
  default = "test"
}

variable "kubernetes_version" {
  type        = string
  default     = "v1.29.4+1"
  description = "kubernets version, use: curl -XGET -H 'Authorization: Bearer $VULTR_API_KEY' 'https://api.vultr.com/v2/kubernetes/versions'" 
}

variable "vcpu_count" {
  type        = string
  default     = "1"
  description = "The amount of vcpu cores."
}

variable "ram" {
  type        = string
  default     = "2048"
  description = "The amount of ram in megabytes."
}

variable "monthly_cost" {
  type        = string
  default     = "10"
  description = "The monthly costage."
}

variable "region_city" {
  type        = string
  default     = "Amsterdam"
  description = "The city name of the region"

  validation {
    condition = anytrue([
      var.region_city == "Amsterdam",
      var.region_city == "Frankfurt",
      var.region_city == "London",
      var.region_city == "Seattle",
      var.region_city == "Sydney",
      var.region_city == "Tokyo"
    ])
    error_message = "City name must match 'Amsterdam', 'Frankfurt', 'London', 'Seattle', 'Sydney', or 'Tokyo'."
  }
}

variable "enabled_apps" {
  description = "Map of apps to be installed with their Helm chart details."
  type = map(object({
    chart            = optional(string)
    repository       = optional(string)
    version          = optional(string)
    namespace        = optional(string)
    create_namespace = optional(bool)
    values_file      = optional(string)
  }))
  default = {}
}

variable "default_apps" {
  description = "Default values for apps"
  type = map(object({
    chart            = string
    repository       = string
    version          = string
    namespace        = string
    create_namespace = bool
    values_file      = string
  }))
  default = {
    "nginx" = {
      chart            = "nginx"
      repository       = "oci://registry-1.docker.io/bitnamicharts"
      version          = "18.1.5"
      namespace        = "default"
      create_namespace = true
      values_file      = "../templates/nginx/values.yaml"
    }
  }
}


