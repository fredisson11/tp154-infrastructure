# --- Provider vars:

variable "gcp_sa_key_file" {
  type        = string
  description = "Path to the GCP service account JSON key file"
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "project" {
  description = "GCP project ID"
  type        = string
}

# --- GKE vars:

variable "gke_environment" {
  description = "Deployment environment (staging or production)"
  type        = string
}

variable "gke_node_count" {
  description = "Number of nodes in the node pool"
  type        = number
}

variable "gke_node_cpu" {
  description = "Number of CPUs per node"
  type        = number
}

variable "gke_machine_family" {
  description = "Machine type family for GKE nodes (e.g. e2-custom)"
  type        = string
}

variable "gke_machine_memory_mb" {
  description = "Amount of memory (in MB) for GKE nodes"
  type        = number
}

variable "gke_preemptible" {
  description = "Use preemptible nodes in GKE node pool"
  type        = bool
}

variable "gke_disk_size_gb" {
  description = "Boot disk size in GB for GKE nodes"
  type        = number
}

variable "gke_disk_type" {
  description = "Boot disk type for GKE nodes (e.g. pd-standard)"
  type        = string
}

variable "gke_deletion_protection" {
  description = "Enable deletion protection on the GKE cluster"
  type        = bool
}

# --- Postgres vars:

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

variable "is_db_firewall_enabled" {
  description = "Whether to create a firewall rule to allow external PostgreSQL access"
  type        = bool
}

variable "db_primary_node_port" {
  description = "Custom NodePort for PostgreSQL primary service"
  type        = string
  default     = "3000"
}

# --- Prometheus Stack vars:

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

# --- Nginx Ingress Controller vars:

variable "controller_svc_external_traffic_policy" {
  description = "External traffic policy for the ingress controller service"
  type        = string
}

variable "controller_svc_load_balancer_type" {
  description = "Load balancer type for the ingress controller service"
  type        = string
}

variable "controller_ingress_class" {
  description = "Ingress class name for the ingress controller"
  type        = string
}
