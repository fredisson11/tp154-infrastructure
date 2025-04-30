variable "ROOT_PASSWORD" {
  type        = string
  description = "Password for the 'postgres' root user"
  sensitive   = true
}

variable "USER" {
  type        = string
  description = "PostgreSQL username"
  sensitive   = true
}

variable "PASSWORD" {
  type        = string
  description = "PostgreSQL password"
  sensitive   = true
}

variable "NAME" {
  type        = string
  description = "PostgreSQL database name"
  sensitive   = true
}

variable "is_pvc_enabled" {
  type        = bool
  description = "Enables database persistence if true"
}

variable "pvc_size" {
  type        = string
  description = "Size of the persistence storage"
}

variable "architecture" {
  type        = string
  description = "Specifies the database deployment mode (standalone or replication)"
}

variable "replica_count" {
  type        = number
  description = "Number of read replicas (total pods = replicas + 1 primary)"
}

variable "REPLICATION_PASSWORD" {
  type        = string
  description = "Password used for PostgreSQL replication user"
  sensitive   = true
}

variable "primary_svc_type" {
  type        = string
  description = "Sets the Kubernetes Service type for primary"
}

variable "replicas_svc_type" {
  type        = string
  description = "Sets the Kubernetes Service type for replicas"
}

variable "primary_node_port" {
  type        = string
  description = "Custom NodePort for PostgreSQL primary service"
}

variable "is_firewall_enabled" {
  type        = bool
  description = "Whether to create a firewall rule to allow external PostgreSQL access"
}