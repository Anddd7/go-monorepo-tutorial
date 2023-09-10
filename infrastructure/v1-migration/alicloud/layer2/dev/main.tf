locals {
  project = "go-mono-tutorial"
  env     = "dev"
}


module "data-consolation" {
  source = "./data-consolation"

  project = local.project
  env     = local.env
}

module "ordering" {
  source = "./ordering"

  project = local.project
  env     = local.env
}

module "transactions" {
  source = "./transactions"

  project = local.project
  env     = local.env
}

module "user-management" {
  source = "./user-management"

  project = local.project
  env     = local.env
}
