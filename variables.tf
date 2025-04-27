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
  sensitive   = true
}

variable "DB_PASSWORD" {
  type        = string
  description = "PostgreSQL password"
  sensitive   = true
}

variable "DB_NAME" {
  type        = string
  description = "PostgreSQL database name"
  sensitive   = true
}

variable "is_db_pvc_enabled" {
  type        = bool
  description = "Enables database persistence if true"
}

variable "db_pvc_size" {
  type        = string
  description = "Size of the persistence storage"
}

variable "db_architecture" {
  type        = string
  description = "Specifies the database deployment mode (standalone or replication)"
}

variable "db_replica_count" {
  type        = number
  description = "Number of read replicas (total pods = replicas + 1 primary)"
}

variable "DB_REPLICATION_PASSWORD" {
  type        = string
  description = "Password used for PostgreSQL replication user"
  sensitive   = true
}

variable "db_primary_svc_type" {
  type        = string
  description = "Sets the Kubernetes Service type for primary"
}

variable "db_replicas_svc_type" {
  type        = string
  description = "Sets the Kubernetes Service type for replicas"
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

variable "gcp_sa_key_file" {
  type        = string
  description = "Path to the GCP service account JSON key file"
}

# -----------------------------------------------------------------
# -----------------------------------------------------------------
# -----------------------------------------------------------------

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
