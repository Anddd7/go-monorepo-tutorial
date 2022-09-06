module "configmap" {
  source = "../../k8s-configmap"

  name      = "product"
  namespace = "${var.env}-ns"
  data      = {
    ENV           = var.env
    PRODUCT_OWNER = "Anddd7"
  }
}
