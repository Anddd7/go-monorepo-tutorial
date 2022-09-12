module "configmap" {
  source = "../../k8s-configmap"

  name      = "product"
  namespace = var.namespace
  data = {
    PRODUCT_OWNER = "Anddd7"
  }
}
