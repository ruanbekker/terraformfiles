resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = keys(var.sans_zone_mapping)

  tags = {
    Name = "${var.domain_name}-certificate"
    Description = "Certificate for ${var.domain_name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for options in aws_acm_certificate.cert.domain_validation_options : options.domain_name => {
      name   = options.resource_record_name
      record = options.resource_record_value
      type   = options.resource_record_type
      zone   = lookup(var.sans_zone_mapping, options.domain_name, var.default_fallback_domain)
    }
  }

  zone_id = data.aws_route53_zone.selected[each.value.zone].zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

data "aws_route53_zone" "selected" {
  for_each    = toset(values(var.sans_zone_mapping))
  name        = each.value
  private_zone = false
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

