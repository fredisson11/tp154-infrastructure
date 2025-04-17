resource "helm_release" "postgres" {
  name       = "postgres"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "12.1.0"

  depends_on = [
    google_container_cluster.k8s_cluster,
    google_container_node_pool.k8s_node_pool
  ]

  set {
    name  = "auth.username"
    value = var.DB_USER
  }

  set {
    name  = "auth.password"
    value = var.DB_PASSWORD
  }

  set {
    name  = "auth.database"
    value = var.DB_NAME
  }

  set {
    name  = "primary.persistence.enabled"
    value = var.is_db_pvc_enabled
  }

  set {
    name  = "primary.persistence.size"
    value = var.db_pvc_size
  }

  set {
    name  = "auth.postgresPassword"
    value = var.DB_ROOT_PASSWORD
  }
}