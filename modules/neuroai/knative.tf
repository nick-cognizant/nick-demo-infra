locals {
  net_istio_manifest_files    = [for i in range(14) : "${path.module}/yaml/net-istio/net-istio${i}.yaml"]
  serving_crds_manifest_files = [for i in range(12) : "${path.module}/yaml/serving-crds/serving-crds${i}.yaml"]
  serving_core_manifest_files = [for i in range(84) : "${path.module}/yaml/serving-core/serving-core${i}.yaml"]
  istio_manifest_files        = [for i in range(53) : "${path.module}/yaml/istio/istio${i}.yaml"]
}

# resource "kubernetes_manifest" "net_istio" {
#   for_each = { for f in local.net_istio_manifest_files : f => f }
#   manifest = yamldecode(file(each.value))
#   depends_on = [helm_release.istio_ingressgateway]
# }

# resource "kubernetes_manifest" "serving_crds" {
#   for_each = { for f in local.serving_crds_manifest_files : f => f }
#   manifest = yamldecode(file(each.value))
# }

# resource "kubernetes_manifest" "serving_core" {
#   for_each = { for f in local.serving_core_manifest_files : f => f }
#   manifest = yamldecode(file(each.value))
# }

# resource "kubernetes_manifest" "istio_1" {
#   for_each = { for f in local.istio_manifest_files : f => f }
#   manifest = yamldecode(file(each.value))
# }