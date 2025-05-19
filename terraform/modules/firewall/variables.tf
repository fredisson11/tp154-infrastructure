variable "rules" {
  description = "Map with firewall rules"
  type = map(object({
    network        = string
    ports          = list(string)
    source_ranges  = list(string)
  }))
}