resource "helm_release" "prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "default"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "70.7.0"

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
    name  = "grafana.persistence.enabled"
    value = var.is_grafana_persistence_enabled
  }

  set {
    name  = "grafana.persistence.size"
    value = var.grafana_pvc_size
  }

  set {
    name  = "grafana.grafana.ini.server.root_url"
    value = var.grafana_root_url
  }

  set {
    name  = "grafana.grafana.ini.server.serve_from_sub_path"
    value = var.grafana_serve_from_sub_path
  }

  set {
    name  = "prometheus.prometheusSpec.externalUrl"
    value = var.prometheus_external_url
  }

  set {
    name  = "prometheus.prometheusSpec.routePrefix"
    value = var.prometheus_route_prefix
  }
}
