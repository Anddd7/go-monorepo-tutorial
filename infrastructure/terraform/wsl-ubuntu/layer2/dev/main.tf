module "configmap" {
  source = "../../../modules/k8s-configmap"

  name      = "shared-configs"
  namespace = "${var.env}-ns"

  data = {
    ENV = var.env
  }
}



module "product" {
  source = "../../../modules/services/product"

  env = var.env
}

module "order" {
  source = "../../../modules/services/order"

  env = var.env
}
