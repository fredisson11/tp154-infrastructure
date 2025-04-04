terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.25.0"
    }
  }
}

provider "azurerm" {
  subscription_id = local.subscription_id
  features {}
}

provider "kubernetes" {
  host                   = local.kube_config.host
  client_certificate     = local.kube_config.client_certificate
  client_key             = local.kube_config.client_key
  cluster_ca_certificate = local.kube_config.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = local.kube_config.host
    client_certificate     = local.kube_config.client_certificate
    client_key             = local.kube_config.client_key
    cluster_ca_certificate = local.kube_config.cluster_ca_certificate
  }
}