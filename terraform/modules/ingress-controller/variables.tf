variable "external_traffic_policy" {
  type        = string
  description = "External traffic policy for the ingress controller service"
}

variable "load_balancer_type" {
  description = "Load balancer type for the ingress controller service"
  type        = string
}

variable "svc_type" {
  description = "Service type for the ingress controller"
  type        = string
  default     = "LoadBalancer"
}

variable "ingress_class" {
  description = "Ingress class name for the ingress controller"
  type        = string
}