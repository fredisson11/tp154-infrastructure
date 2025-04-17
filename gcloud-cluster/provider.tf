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

provider "kubernetes" {
  host                   = local.kube_config.host
  cluster_ca_certificate = local.kube_config.cluster_ca_certificate
  token                  = local.kube_config.token
}

provider "helm" {
  kubernetes {
    host                   = local.kube_config.host
    cluster_ca_certificate = local.kube_config.cluster_ca_certificate
    token                  = local.kube_config.token
  }
}