# resource "aws_security_group" "eks_cluster_sg" {
#   name        = "${var.name}-eks-cluster-sg"
#   description = "Security group for EKS cluster"

#   # Ingress rules
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Egress rules
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }