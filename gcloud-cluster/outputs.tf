output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = google_container_cluster.k8s_cluster.name
}

output "kubernetes_cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = google_container_cluster.k8s_cluster.endpoint
}

output "kubernetes_cluster_ca_certificate" {
  description = "The base64 encoded public CA certificate for the Kubernetes master"
  value       = google_container_cluster.k8s_cluster.master_auth[0].cluster_ca_certificate
}

output "postgresql_connection_string" {
  description = "Connection string for PostgreSQL"
  value       = "postgresql://${var.DB_USER}:${var.DB_PASSWORD}@postgres.${var.environment}.svc.cluster.local:5432/${var.DB_NAME}"
  sensitive   = true
}

output "prometheus_url" {
  description = "URL for Prometheus"
  value       = "http://${google_container_cluster.k8s_cluster.endpoint}/prometheus"
}

output "grafana_url" {
  description = "URL for Grafana"
  value       = "http://${google_container_cluster.k8s_cluster.endpoint}/grafana"
}
