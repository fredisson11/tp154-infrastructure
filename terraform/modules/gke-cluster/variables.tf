variable "environment" {
  description = "Deployment environment (staging or production)"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the node pool"
  type        = number
}

variable "machine_family" {
  description = "GCE machine type family (e.g. e2-custom)"
  type        = string
}

variable "node_cpu" {
  description = "Number of vCPUs per node"
  type        = number
}

variable "machine_memory_mb" {
  description = "Amount of memory in MB per node"
  type        = number
}

variable "deletion_protection" {
  description = "Enable or disable deletion protection on the GKE cluster"
  type        = bool
}

variable "preemptible" {
  description = "Whether to use preemptible VMs in the node pool"
  type        = bool
}

variable "disk_size_gb" {
  description = "Size of the boot disk in GB"
  type        = number
}

variable "disk_type" {
  description = "Type of the disk to use (e.g. pd-standard, pd-balanced)"
  type        = string
}
