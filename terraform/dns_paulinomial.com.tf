data "cloudflare_zones" "paulinomial_com" {
  filter {
    name = "paulinomial.com"
  }
}

resource "cloudflare_record" "root_paulinomial_CNAME" {
  zone_id = data.cloudflare_zones.paulinomial_com.zones[0].id
  type    = "CNAME"
  name    = "@"
  value   = "09925797-6349-431c-abc6-aeca6a18c50f.cfargotunnel.com"
  proxied = true
}

resource "cloudflare_record" "www_paulinomial_CNAME" {
  zone_id = data.cloudflare_zones.paulinomial_com.zones[0].id
  type    = "CNAME"
  name    = "www"
  value   = "09925797-6349-431c-abc6-aeca6a18c50f.cfargotunnel.com"
  proxied = true
}
