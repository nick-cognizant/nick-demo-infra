# Create the EKS node group
resource "aws_eks_node_group" "sandbox_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.name}-node-group"

  for_each = var.node_group_scaling_configs

  scaling_config {
    desired_size = each.value.desired_size
    min_size     = each.value.min_size
    max_size     = each.value.max_size
  }

  remote_access {
    ec2_ssh_key = var.remote_access_key
  }

  subnet_ids    = var.node_group_subnet_ids
  node_role_arn = aws_iam_role.node_group_role.arn
}