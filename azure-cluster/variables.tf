variable "name_prefix" {
  type        = string
  description = ""
  default     = "default"
}

variable "location" {
  type        = string
  description = ""
  default     = "East US"
}

variable "network_rules" {
  description = "A map of allowed traffic rules with port ranges and CIDR blocks."
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
}


