# Create the EKS node group
resource "aws_eks_node_group" "sandbox_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.name}-node-group"

  for_each = var.node_group_scaling_configs

  instance_types = ["t3.xlarge"]
  scaling_config {
    desired_size = each.value.desired_size
    min_size     = each.value.min_size
    max_size     = each.value.max_size
  }

  # remote_access {
  #   ec2_ssh_key = var.remote_access_key
  # }

  subnet_ids    = var.node_group_subnet_ids
  node_role_arn = aws_iam_role.node_group_role.arn
}

# Attach the managed policy to the role
resource "aws_iam_role_policy_attachment" "additional_policy_attachment" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}
