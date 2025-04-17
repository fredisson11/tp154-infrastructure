resource "helm_release" "prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "default"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "70.7.0"

  depends_on = [
    google_container_cluster.k8s_cluster,
    google_container_node_pool.k8s_node_pool
  ]

  set {
    name  = "grafana.adminUser"
    value = var.GRAFANA_ADMIN_USER
  }

  set {
    name  = "grafana.adminPassword"
    value = var.GRAFANA_ADMIN_PASSWORD
  }

  set {
    name  = "prometheus.prometheusSpec.retention"
    value = "7d"
  }

  set {
    name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage"
    value = var.prometheus_pvc_size
  }

  set {
    name  = "alertmanager.enabled"
    value = var.is_alertmanager_enabled
  }

  set {
    name  = "grafana.persistence.enabled"
    value = var.is_grafana_persistence_enabled
  }

  set {
    name  = "grafana.persistence.size"
    value = var.grafana_pvc_size
  }
}