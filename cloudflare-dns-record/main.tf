data "cloudflare_zone" "this" {
  name = var.domain_name
}

resource "cloudflare_record" "this" {
  zone_id = data.cloudflare_zone.this.id
  name    = "foobar"
  value   = "127.0.0.1"
  type    = "A"
  proxied = false
}
