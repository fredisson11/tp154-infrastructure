resource "google_compute_firewall" "rules" {
  for_each = var.rules

  name    = each.key
  network = each.value.network

  allow {
    protocol = "tcp"
    ports    = each.value.ports
  }

  source_ranges = each.value.source_ranges
}