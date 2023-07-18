provider "aws" {
  region  = "us-west-2"
  # profile = "devAdmin"
}

terraform {
  backend "s3" {
    bucket  = "leaf-infra"
    key     = "tfstate/dev/eks-sandbox/terraform.tfstate"
    region  = "us-west-2"
    # profile = "devAdmin"
  }
}

module "sandbox-network" {
  source = "./modules/network"
}

module "sandbox-eks" {
  source      = "./modules/eks"
  name        = "sandbox"
  k8s_version = "1.24"

  cluster_subnets = [module.sandbox-network.subnet1_id, module.sandbox-network.subnet2_id]
  node_group_scaling_configs = {
    worker = {
      desired_size = 3
      min_size     = 1
      max_size     = 5
    }
  }
  node_group_subnet_ids = [module.sandbox-network.subnet1_id, module.sandbox-network.subnet2_id]
  remote_access_key     = "sandbox-dev-key-pair"
}

module "service-account"{
  source = "./modules/service-account"
  host = module.sandbox-eks.host
  cluster_ca_certificate = module.sandbox-eks.cluster_ca_certificate
  token = module.sandbox-eks.token
  url = module.sandbox-eks.url
}

module "argocd" {
  source                 = "./modules/argocd"
  host                   = module.sandbox-eks.host
  cluster_ca_certificate = module.sandbox-eks.cluster_ca_certificate
  token                  = module.sandbox-eks.token
  url                    = module.sandbox-eks.url
}