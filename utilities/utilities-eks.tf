provider "aws" {
  region  = "us-west-2"
  profile = "daiAdmin"
}

terraform {
  backend "s3" {
    bucket  = "utilities-infra"
    key     = "tfstate/eks-utilities/terraform.tfstate"
    region  = "us-west-2"
    profile = "daiAdmin"
  }
}

module "utilities-network" {
  source              = "../modules/network"
  name                = var.name
  vpc_cidr_blocks     = "10.1.0.0/16"
  subnet1_cidr_blocks = "10.1.1.0/24"
  subnet2_cidr_blocks = "10.1.2.0/24"
}

module "utilities-eks" {
  source      = "../modules/eks"
  name        = var.name
  k8s_version = "1.24"

  cluster_subnets = [module.utilities-network.subnet1_id, module.utilities-network.subnet2_id]
  node_group_scaling_configs = {
    worker = {
      desired_size = 3
      min_size     = 1
      max_size     = 5
    }
  }
  node_group_subnet_ids = [module.utilities-network.subnet1_id, module.utilities-network.subnet2_id]
  remote_access_key     = "utilities-dev-key-pair"
}

module "service-account" {
  source                 = "../modules/service-account"
  name                   = var.name
  host                   = module.utilities-eks.host
  cluster_ca_certificate = module.utilities-eks.cluster_ca_certificate
  token                  = module.utilities-eks.token
  url                    = module.utilities-eks.url
}

module "argocd" {
  source                 = "../modules/argocd"
  host                   = module.utilities-eks.host
  cluster_ca_certificate = module.utilities-eks.cluster_ca_certificate
  token                  = module.utilities-eks.token
  url                    = module.utilities-eks.url
}