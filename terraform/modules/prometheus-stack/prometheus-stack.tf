resource "helm_release" "prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "default"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "70.7.0"

  set {
    name  = "prometheus.prometheusSpec.retention"
    value = var.prometheus_retention
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
    name  = "grafana.adminUser"
    value = var.GRAFANA_ADMIN_USER
  }

  set {
    name  = "grafana.adminPassword"
    value = var.GRAFANA_ADMIN_PASSWORD
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
