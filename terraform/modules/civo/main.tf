resource "civo_kubernetes_cluster" "platform" {
  name        = "Platform"
  region      = "MUM1"
  cni         = "cilium"
  firewall_id = var.civo_firewall_id

  pools {
    label      = "default"
    size       = "g4s.kube.large"
    node_count = 2
  }
}

output "civo_cluster_api_endpoint" {
  value = civo_kubernetes_cluster.platform.api_endpoint
}

output "civo_cluster_dns_name" {
  value = civo_kubernetes_cluster.platform.dns_entry
}
