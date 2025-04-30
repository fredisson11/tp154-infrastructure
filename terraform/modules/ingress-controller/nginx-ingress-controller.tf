resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  version    = "9.3.19"

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = var.external_traffic_policy
  }

  set {
    name  = "controller.service.annotations.service.beta.kubernetes.io/aws-load-balancer-type"
    value = var.load_balancer_type
  }

  set {
    name  = "controller.service.type"
    value = var.svc_type
  }

  set {
    name  = "controller.ingressClass"
    value = var.ingress_class
  }
}