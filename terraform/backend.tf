terraform {
  backend "local" {
    path = "./envs/staging/terraform.tfstate"
  }
}