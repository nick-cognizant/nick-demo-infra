# Create the EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.k8s_version

  vpc_config {
    subnet_ids         = var.cluster_subnets
    # security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}