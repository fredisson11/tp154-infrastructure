resource "helm_release" "ingress" {
  name = "ingress"
  namespace = "default"
  repository = "${path.root}/../helm-charts/"
  chart = "ingress"
  version = "1.0.0"

  set {
    name = "basicAuth.enabled"
    value = true
  }

  dynamic "set" {
    for_each = var.basic_auth_enabled ? {
      "basicAuth.basicAuthUsername" = var.BASIC_AUTH_USER
      "basicAuth.basicAuthPassword" = var.BASIC_AUTH_PASSWORD
    } : {}

    content {
      name = set.key
      value = set.value
    }
  }
}