resource "helm_release" "prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "default"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "70.7.0"

  values = [
    templatefile("${path.module}/grafana-values.yml", {
      GRAFANA_ADMIN_USER             = var.GRAFANA_ADMIN_USER
      GRAFANA_ADMIN_PASSWORD         = var.GRAFANA_ADMIN_PASSWORD
      is_grafana_persistence_enabled = var.is_grafana_persistence_enabled
      grafana_pvc_size               = var.grafana_pvc_size
    })
  ]

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
    name  = "prometheus.prometheusSpec.externalUrl"
    value = var.prometheus_external_url
  }

  set {
    name  = "prometheus.prometheusSpec.routePrefix"
    value = var.prometheus_route_prefix
  }

  # set {
  #   name  = "prometheusOperator.service.targetPort"
  #   value = "10250"
  # }
}
