module "product" {
  source = "../../../../services/product/terraform"

  env       = var.env
  namespace = var.namespace
}

module "order" {
  source = "../../../../services/order/terraform"

  env       = var.env
  namespace = var.namespace
}
