terraform {
  backend "local" {
    path = "./envs/development/terraform.tfstate"
  }
}