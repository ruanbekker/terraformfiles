variable "domain_name" {
  description = "The domain name for which the certificate should be issued."
  type        = string
}

variable "sans_zone_mapping" {
  description = "Map of domain names (including primary domain and SANs) to their corresponding Route 53 Zone FQDNs."
  type        = map(string)
}

variable "default_fallback_domain" {
  description = "The domain zone in AWS Route53 it will fallback if no value was found."
  type        = string
}

