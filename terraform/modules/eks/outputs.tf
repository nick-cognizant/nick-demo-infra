data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

output "host" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "cluster_ca_certificate" {
  value = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

output "token" {
  value = data.aws_eks_cluster_auth.cluster.token
}

output "url"{
  value = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}