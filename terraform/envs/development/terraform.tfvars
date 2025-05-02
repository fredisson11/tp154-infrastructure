gcp_sa_key_file = "./envs/development/GCP_SERVICE_ACCOUNT_KEY.json"
project         = "arctic-shadow-457010-g7"
region          = "europe-west1-b"

gke_environment     = "development"
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
db_primary_svc_type  = "LoadBalancer"
db_replicas_svc_type = "ClusterIP"

is_db_firewall_enabled = true
db_primary_node_port   = "30000"

prometheus_pvc_size            = "10Gi"
prometheus_retention           = "7d"
is_grafana_persistence_enabled = true
grafana_pvc_size               = "5Gi"
is_alertmanager_enabled        = true
grafana_root_url               = "http://localhost/grafana/"
grafana_serve_from_sub_path    = "true"
prometheus_external_url        = "http://localhost/prometheus"
prometheus_route_prefix        = "/prometheus"

controller_svc_external_traffic_policy = "Local"
controller_svc_load_balancer_type      = "nlb"
controller_ingress_class               = "nginx"

ingress_basic_auth_enabled = true