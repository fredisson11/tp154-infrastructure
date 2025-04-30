resource "google_compute_firewall" "allow_postgres" {
  name    = "allow-postgres"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000"]
  }

  source_ranges = ["0.0.0.0/0"]
}