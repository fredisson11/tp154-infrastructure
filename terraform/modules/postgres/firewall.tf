resource "google_compute_firewall" "allow_postgres" {
  count = var.is_firewall_enabled ? 1 : 0

  name    = "allow-postgres"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000"]
  }

  source_ranges = ["0.0.0.0/0"]
}