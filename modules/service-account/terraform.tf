terraform {
  required_version = ">= 1.5.0"
}

provider "kubernetes" {
  host                   = var.host
  cluster_ca_certificate = var.cluster_ca_certificate
  token                  = var.token
}