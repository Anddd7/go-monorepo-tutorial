module "product" {
  source = "../../../modules/services/product"

  env = var.env
}

module "order" {
  source = "../../../modules/services/order"

  env = var.env
}
