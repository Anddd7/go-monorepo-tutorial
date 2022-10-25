module "configmap" {
  source = "../../../infrastructure/modules/k8s-configmap"

  name      = "product"
  namespace = var.namespace
  data = {
    PRODUCT_OWNER = "Anddd7"
  }
}
