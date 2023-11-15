module "acm_certificate" {
  source                  = "../"
  domain_name             = "dev.example.com"
  default_fallback_domain = "dev.example.com."
  sans_zone_mapping = {
    "*.dev.example.com"   = "dev.example.com."
    "*.test.example.com"  = "test.example.com."
  }
}

output "certificate_arn" {
  value       = module.acm_certificate.arn
  description = "The ACM Certificate ARN String."
}
