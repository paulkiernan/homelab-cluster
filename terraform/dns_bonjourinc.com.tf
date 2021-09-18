data "cloudflare_zones" "bonjourinc_com" {
  filter {
    name = "bonjourinc.com"
  }
}

resource "cloudflare_record" "root_bonjourinc_CNAME" {
  zone_id = data.cloudflare_zones.bonjourinc_com.zones[0].id
  type    = "CNAME"
  name    = "@"
  value   = "09925797-6349-431c-abc6-aeca6a18c50f.cfargotunnel.com"
  proxied = true
}

resource "cloudflare_record" "www_bonjourinc_CNAME" {
  zone_id = data.cloudflare_zones.bonjourinc_com.zones[0].id
  type    = "CNAME"
  name    = "www"
  value   = "09925797-6349-431c-abc6-aeca6a18c50f.cfargotunnel.com"
  proxied = true
}

resource "cloudflare_record" "bonjour_bonjourinc_CNAME" {
  zone_id = data.cloudflare_zones.bonjourinc_com.zones[0].id
  type    = "CNAME"
  name    = "bonjour"
  value   = "09925797-6349-431c-abc6-aeca6a18c50f.cfargotunnel.com"
  proxied = true
}
