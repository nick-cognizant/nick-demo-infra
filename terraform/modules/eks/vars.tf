variable "name" {
  type = string
}

variable "k8s_version" {
  type        = string
  description = "The version of kubernetes"
}

variable "cluster_subnets" {
  type = list(any)
}

# variable "cluster_sg" {
#   type = list(any)
# }

variable "node_group_scaling_configs" {
  type = map(object({
    desired_size = number
    min_size     = number
    max_size     = number
  }))
}

variable "remote_access_key" {
  type = string
}

variable "node_group_subnet_ids" {
  type = list(any)
}
