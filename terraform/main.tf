module "civo" {
  source           = "./modules/civo"
  civo_firewall_id = var.civo_firewall_id
}

module "aws" {
  source     = "./modules/aws"
  aws_region = var.aws_region
}

module "azure" {
  source                             = "./modules/azure"
  azure_github_service_connection_id = var.azure_github_service_connection_id
}

module "cloudflare" {
  source             = "./modules/cloudflare"
  cloudflare_zone_id = var.cloudflare_zone_id
  ingress_ip         = var.ingress_ip
  audio_service_ip   = var.audio_service_ip
}
