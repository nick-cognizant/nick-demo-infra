resource "kubernetes_namespace" "istio" {
  metadata {
    name = "istio-system"
  }
}

resource "kubernetes_namespace" "knative_serving" {
  metadata {
    name = "knative-serving"
  }
}