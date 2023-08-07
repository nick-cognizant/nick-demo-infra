provider "kubernetes" {
  host                   = var.host
  cluster_ca_certificate = var.cluster_ca_certificate
  token                  = var.token
}

provider "helm" {
  kubernetes {
    host                   = var.host
    cluster_ca_certificate = var.cluster_ca_certificate
    token                  = var.token
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "xc"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.37.0"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  set {
    name  = "installCRDs"
    value = "false"
  }
  
  set {
    name  = "server.extraArgs"
    value = "{--insecure}"
  }

  set {
    name  = "controller.args.appResyncPeriod"
    value = "180"
  }

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}
