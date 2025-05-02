variable "basic_auth_enabled" {
  type = bool
  description = "Enable or disable basic HTTP authentication for ingress"
}

variable "BASIC_AUTH_USER" {
  type = string
  description = "Username for basic HTTP authentication"
}

variable "BASIC_AUTH_PASSWORD" {
  type = string
  description = "Password for basic HTTP authentication"
}