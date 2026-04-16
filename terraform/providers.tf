provider "civo" {
  token  = var.civo_token
  region = "MUM1"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/lsuthar"
  personal_access_token = var.azure_pat
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
