module "gcloud_cluster" {
  source = "./modules/gcloud-cluster"

  gcp_sa_key_file = var.gcp_sa_key_file
  environment     = var.environment
  region          = var.region
  project         = var.project

  node_count = var.node_count
  node_cpu   = var.node_cpu

  is_db_pvc_enabled = var.is_db_pvc_enabled
  db_pvc_size       = var.db_pvc_size
  db_architecture   = var.db_architecture
  db_replica_count  = var.db_replica_count
  db_svc_type       = var.db_svc_type

  prometheus_pvc_size            = var.prometheus_pvc_size
  prometheus_retention           = var.prometheus_retention
  is_grafana_persistence_enabled = var.is_grafana_persistence_enabled
  grafana_pvc_size               = var.grafana_pvc_size
  is_alertmanager_enabled        = var.is_alertmanager_enabled

  DB_ROOT_PASSWORD    = var.DB_ROOT_PASSWORD
  DB_USER             = var.DB_USER
  DB_PASSWORD         = var.DB_PASSWORD
  DB_NAME             = var.DB_NAME
  DB_REPLICA_PASSWORD = var.DB_REPLICA_PASSWORD

  GRAFANA_ADMIN_USER     = var.GRAFANA_ADMIN_USER
  GRAFANA_ADMIN_PASSWORD = var.GRAFANA_ADMIN_PASSWORD

}