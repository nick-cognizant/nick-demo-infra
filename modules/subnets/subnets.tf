resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "127.31.0.64/20"

  tags = {
    Name                                = "example"
    "kubernetes.io/cluster/${clusterName}" = "shared"
    "kubernetes.io/role/elb"               = "1"
  }
}