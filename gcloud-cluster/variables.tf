variable "environment" {
  description = "Deployment environment (staging or production)"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the node pool"
  type        = number
}

variable "node_cpu" {
  description = "Number of CPUs per node"
  type        = number
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "DB_ROOT_PASSWORD" {
  type        = string
  description = "Password for the 'postgres' root user"
  sensitive   = true
}

variable "DB_USER" {
  type        = string
  description = "PostgreSQL username"
}

variable "DB_PASSWORD" {
  type        = string
  description = "PostgreSQL password"
  sensitive   = true
}

variable "DB_NAME" {
  type        = string
  description = "PostgreSQL database name"
}

variable "is_db_pvc_enabled" {
  type        = bool
  description = "Enables database persistence if true"
}

variable "db_pvc_size" {
  type        = string
  description = "Size of the persistence storage"
}

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