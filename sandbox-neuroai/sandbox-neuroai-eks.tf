provider "aws" {
  region  = "us-west-2"
  profile = "devAdmin"
}

terraform {
  backend "s3" {
    bucket  = "leaf-infra"
    key     = "tfstate/dev/eks-sandbox-neuroai/terraform.tfstate"
    region  = "us-west-2"
    profile = "devAdmin"
  }
}

module "sandbox-neuroai-network" {
  source = "../modules/network"
  name = "sandbox-neuroai"
  vpc_cidr_blocks = "10.1.0.0/16"
  subnet1_cidr_blocks = "10.1.1.0/24"
  subnet2_cidr_blocks = "10.1.2.0/24"
}

module "sandbox-neuroai-eks" {
  source      = "../modules/eks"
  name        = "sandbox-neuroai"
  k8s_version = "1.24"

  cluster_subnets = [module.sandbox-neuroai-network.subnet1_id, module.sandbox-neuroai-network.subnet2_id]
  node_group_scaling_configs = {
    worker = {
      desired_size = 3
      min_size     = 1
      max_size     = 5
    }
  }
  node_group_subnet_ids = [module.sandbox-neuroai-network.subnet1_id, module.sandbox-neuroai-network.subnet2_id]
  remote_access_key     = "sandbox-dev-key-pair"
}