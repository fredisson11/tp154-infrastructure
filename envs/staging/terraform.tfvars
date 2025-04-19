environment = "staging"
node_count  = 2
node_cpu    = 2
region      = "europe-west1-b"
project     = "arctic-shadow-457010-g7"

is_db_pvc_enabled    = true
db_pvc_size          = "3Gi"
db_architecture      = "replication"
db_replica_count     = 1
db_primary_svc_type  = "LoadBalancer"
db_replicas_svc_type = "ClusterIP"

prometheus_pvc_size            = "10Gi"
prometheus_retention           = "7d"
is_grafana_persistence_enabled = true
grafana_pvc_size               = "5Gi"
is_alertmanager_enabled        = true

gcp_sa_key_file = "./GCP_SERVICE_ACCOUNT_KEY.json"