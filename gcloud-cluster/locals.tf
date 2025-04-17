data "google_client_config" "gcp_auth" {}

locals {
  kube_config = {
    host                   = google_container_cluster.k8s_cluster.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.k8s_cluster.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.gcp_auth.access_token
  }
}