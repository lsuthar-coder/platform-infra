resource "cloudflare_record" "api" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  content = var.ingress_ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "flags" {
  zone_id = var.cloudflare_zone_id
  name    = "flags"
  content = var.ingress_ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "grafana" {
  zone_id = var.cloudflare_zone_id
  name    = "grafana"
  content = var.ingress_ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "logs" {
  zone_id = var.cloudflare_zone_id
  name    = "logs"
  content = var.ingress_ip
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "audio" {
  zone_id = var.cloudflare_zone_id
  name    = "audio"
  content = var.audio_service_ip
  type    = "A"
  proxied = false
}
