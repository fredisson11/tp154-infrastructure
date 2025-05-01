data "google_client_config" "gcp_auth" {}

locals {
  kube_config = {
    host                   = module.gke_cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca_certificate)
    token                  = data.google_client_config.gcp_auth.access_token
  }
}
