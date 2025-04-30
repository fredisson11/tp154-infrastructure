resource "google_container_cluster" "k8s_cluster" {
  name                = "${var.environment}-cluster"
  location            = var.region
  deletion_protection = var.deletion_protection

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "k8s_node_pool" {
  name     = "${var.environment}-node-pool"
  location = var.region
  cluster  = google_container_cluster.k8s_cluster.name

  node_config {
    machine_type = "${var.machine_family}-${var.node_cpu}-${var.machine_memory_mb}"
    preemptible  = var.preemptible
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type
  }

  initial_node_count = var.node_count
}