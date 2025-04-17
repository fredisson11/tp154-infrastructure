terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.30.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_container_cluster" "k8s_cluster" {
  name                = "${var.environment}-cluster"
  location            = var.region
  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "k8s_node_pool" {
  name     = "${var.environment}-node-pool"
  location = var.region
  cluster  = google_container_cluster.k8s_cluster.name

  node_config {
    machine_type = "e2-custom-${var.node_cpu}-4096"
    preemptible  = true
    disk_size_gb = 50
    disk_type    = "pd-standard"
  }

  initial_node_count = var.node_count
}