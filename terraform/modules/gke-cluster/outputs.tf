output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = google_container_cluster.k8s_cluster.name
}

output "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = google_container_cluster.k8s_cluster.endpoint
}

output "cluster_ca_certificate" {
  description = "The base64 encoded public CA certificate for the Kubernetes master"
  value       = google_container_cluster.k8s_cluster.master_auth[0].cluster_ca_certificate
}
