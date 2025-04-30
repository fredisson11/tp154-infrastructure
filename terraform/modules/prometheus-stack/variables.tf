variable "GRAFANA_ADMIN_USER" {
  type        = string
  description = "Admin username for Grafana"
}

variable "GRAFANA_ADMIN_PASSWORD" {
  type        = string
  description = "Admin password for Grafana"
  sensitive   = true
}

variable "prometheus_pvc_size" {
  type        = string
  description = "Storage size for Prometheus data"
}

variable "is_grafana_persistence_enabled" {
  type        = bool
  description = "Enable Grafana persistent volume"
}

variable "grafana_pvc_size" {
  type        = string
  description = "Persistent volume size for Grafana"
}

variable "prometheus_retention" {
  type        = string
  description = "The retention period for Prometheus metrics"
}

variable "is_alertmanager_enabled" {
  type        = bool
  description = "Flag to enable/disable Alertmanager"
}
# ==== !!!!
variable "grafana_root_url" {
  type        = string
  description = "Root URL for Grafana server"
}

variable "grafana_serve_from_sub_path" {
  type        = bool
  description = "Whether Grafana serves from subpath"
}

variable "prometheus_external_url" {
  type        = string
  description = "External URL for Prometheus"
}

variable "prometheus_route_prefix" {
  type        = string
  description = "Route prefix for Prometheus"
}
