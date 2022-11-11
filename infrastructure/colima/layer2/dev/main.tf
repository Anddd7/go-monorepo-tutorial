resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

module "product" {
  source = "../../../../services/product/terraform"

  env       = var.env
  namespace = kubernetes_namespace.namespace.metadata.0.name
}

module "order" {
  source = "../../../../services/order/terraform"

  env       = var.env
  namespace = kubernetes_namespace.namespace.metadata.0.name
}
