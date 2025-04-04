terraform {
  backend "azurerm" {
    resource_group_name  = "mate-resources"
    storage_account_name = "matestorage11"
    container_name       = "tp154-tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}