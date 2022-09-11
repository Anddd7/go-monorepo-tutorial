module "configmap" {
  source = "../../k8s-configmap"

  name      = "product"
  namespace = "${var.env}-ns"
  data = {
    PRODUCT_OWNER = "Anddd7"
  }
}
