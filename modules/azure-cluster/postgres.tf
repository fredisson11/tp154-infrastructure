resource "helm_release" "postgres" {
  name       = "postgres"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "12.1.0"

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
    value = "true"
  }

  set {
    name  = "primary.persistence.size"
    value = "8Gi"
  }

  set {
    name  = "auth.postgresPassword"
    value = var.DB_ROOT_PASSWORD
  }
}