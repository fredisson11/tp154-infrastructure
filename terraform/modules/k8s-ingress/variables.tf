variable "namespace" {
  description = "Namespace where the NGINX Ingress Controller will be installed"
  type        = string
  default     = "default"
}

variable "controller_svc_external_traffic_policy" {
  description = "External traffic policy for the ingress controller service"
  type        = string
  default     = "Local"
}

variable "controller_svc_load_balancer_type" {
  description = "Load balancer type for the ingress controller service"
  type        = string
  default     = "nlb"
}

variable "controller_svc_type" {
  description = "Service type for the ingress controller"
  type        = string
  default     = "LoadBalancer"
}

variable "controller_ingress_class" {
  description = "Ingress class name for the ingress controller"
  type        = string
  default     = "nginx"
}