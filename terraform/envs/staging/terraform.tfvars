gcp_sa_key_file = "./envs/staging/GCP_SERVICE_ACCOUNT_KEY.json"
project         = "tp154-staging"
region          = "europe-west1-b"

gke_environment    = "staging"
gke_node_count          = 2
gke_machine_family      = "e2-custom"
gke_node_cpu            = 2
gke_machine_memory_mb   = 4096
gke_deletion_protection = false
gke_preemptible         = true
gke_disk_size_gb        = 50
gke_disk_type           = "pd-standard"

is_db_pvc_enabled    = true
db_pvc_size          = "3Gi"
db_architecture      = "replication"
db_replica_count     = 1
db_primary_svc_type  = "ClusterIP"
db_replicas_svc_type = "ClusterIP"

prometheus_pvc_size            = "10Gi"
prometheus_retention           = "7d"
is_grafana_persistence_enabled = true
grafana_pvc_size               = "5Gi"
is_alertmanager_enabled        = true

firewall_rules = {
  # "allow-backend" = {
  #   network       = "default"
  #   ports         = ["8000"]
  #   source_ranges = ["0.0.0.0/0"]
  # },
  # "allow-postgres" = {
  #   network       = "default"
  #   ports         = ["30000"]
  #   source_ranges = ["0.0.0.0/0"]
  # },
  "allow-frontend" = {
    network       = "default"
    ports         = ["3000"]
    source_ranges = ["0.0.0.0/0"]
  }
}
