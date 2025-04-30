# gcp_sa_key_file = var.gcp_sa_key_file

module "gke_cluster" {
  source = "./modules/gke-cluster"

  environment = var.gke_environment
  region      = var.region

  machine_family    = var.gke_machine_family
  node_cpu          = var.gke_node_cpu
  machine_memory_mb = var.gke_machine_memory_mb

  node_count          = var.gke_node_count
  preemptible         = var.gke_preemptible
  disk_size_gb        = var.gke_disk_size_gb
  disk_type           = var.gke_disk_type
  deletion_protection = var.gke_deletion_protection

}

module "postgres" {
  source     = "./modules/postgres"
  depends_on = [module.gke_cluster]

  ROOT_PASSWORD        = var.DB_ROOT_PASSWORD
  USER                 = var.DB_USER
  PASSWORD             = var.DB_PASSWORD
  NAME                 = var.DB_NAME
  REPLICATION_PASSWORD = var.DB_REPLICATION_PASSWORD

  is_pvc_enabled    = var.is_db_pvc_enabled
  pvc_size          = var.db_pvc_size
  architecture      = var.db_architecture
  replica_count     = var.db_replica_count
  primary_svc_type  = var.db_primary_svc_type
  replicas_svc_type = var.db_replicas_svc_type

  is_firewall_enabled = var.is_db_firewall_enabled
  primary_node_port   = var.db_primary_node_port

}

module "prometheus-stack" {
  source     = "./modules/prometheus-stack"
  depends_on = [module.gke_cluster]

  prometheus_pvc_size            = var.prometheus_pvc_size
  prometheus_retention           = var.prometheus_retention
  is_grafana_persistence_enabled = var.is_grafana_persistence_enabled
  grafana_pvc_size               = var.grafana_pvc_size
  is_alertmanager_enabled        = var.is_alertmanager_enabled

  GRAFANA_ADMIN_USER     = var.GRAFANA_ADMIN_USER
  GRAFANA_ADMIN_PASSWORD = var.GRAFANA_ADMIN_PASSWORD

  grafana_root_url            = var.grafana_root_url
  grafana_serve_from_sub_path = var.grafana_serve_from_sub_path
  prometheus_external_url     = var.prometheus_external_url
  prometheus_route_prefix     = var.prometheus_route_prefix

}

module "ingress-controller" {
  source     = "./modules/ingress-controller"
  depends_on = [module.gke_cluster]

  external_traffic_policy = var.controller_svc_external_traffic_policy
  ingress_class           = var.controller_ingress_class
  load_balancer_type      = var.controller_svc_load_balancer_type

}
