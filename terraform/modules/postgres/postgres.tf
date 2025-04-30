resource "helm_release" "postgres" {
  name       = "postgres"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "12.1.0"

  set {
    name  = "auth.username"
    value = var.USER
  }

  set {
    name  = "auth.password"
    value = var.PASSWORD
  }

  set {
    name  = "auth.database"
    value = var.NAME
  }

  set {
    name  = "primary.persistence.enabled"
    value = var.is_pvc_enabled
  }

  set {
    name  = "primary.persistence.size"
    value = var.pvc_size
  }

  set {
    name  = "auth.postgresPassword"
    value = var.ROOT_PASSWORD
  }

  set {
    name  = "architecture"
    value = var.architecture
  }

  set {
    name  = "readReplicas.replicaCount"
    value = var.replica_count
  }

  set {
    name  = "auth.replicationPassword"
    value = var.REPLICATION_PASSWORD
  }

  set {
    name  = "primary.service.type"
    value = var.primary_svc_type
  }

  set {
    name  = "readReplicas.service.type"
    value = var.replicas_svc_type
  }

  dynamic "set" {
    for_each = var.is_firewall_enabled ? [1] : []
    content {
      name  = "primary.service.nodePorts.postgresql"
      value = var.primary_node_port
    }
  }
}