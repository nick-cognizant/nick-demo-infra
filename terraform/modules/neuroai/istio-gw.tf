
provider "helm" {
  kubernetes {
    host                   = var.host
    cluster_ca_certificate = var.cluster_ca_certificate
    token                  = var.token
  }
}

provider "kubernetes" {
  host                   = var.host
  cluster_ca_certificate = var.cluster_ca_certificate
  token                  = var.token
}

resource "helm_release" "istio_base" {
  name       = "istio-base"
  namespace  = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  version    = "1.13.9"
}

resource "helm_release" "istiod" {
  name       = "istiod"
  namespace  = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  version    = "1.13.9"
  depends_on = [helm_release.istio_base]
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "metrics-server"
  chart      = "metrics-server"
  version    = "3.10.0"
  namespace  = "kube-system"

  set {
    name  = "apiService.create"
    value = "true"
  }

  set {
    name  = "extraArgs.kubelet-insecure-tls"
    value = "true"
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "eks"
  chart      = "eks/aws-load-balancer-controller"
  version    = "1.5.4"

  set {
    name  = "clusterName"
    value = "sandbox"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
}


# resource "helm_release" "istio_ingressgateway" {
#   name       = "istio-ingressgateway"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "gateway"
#   version    = "1.13.9"
#   namespace  = "default"
#   values = [
#     file("${path.module}/yaml/values.yaml")
#   ]
# }