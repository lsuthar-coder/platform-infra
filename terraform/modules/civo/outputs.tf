output "cluster_api_endpoint" {
  value = civo_kubernetes_cluster.platform.api_endpoint
}
output "cluster_dns_name" {
  value = civo_kubernetes_cluster.platform.dns_entry
}
