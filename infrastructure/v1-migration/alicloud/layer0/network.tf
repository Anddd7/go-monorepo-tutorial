locals {
  cidr_config               = yamldecode(file("./vpc-cidr.yaml"))
  central_china_cidr_config = local.cidr_config["central_china"]
  nonprod_cidr_config       = local.cidr_config[var.region]["nonprod"]
  internet_cidr_config      = local.cidr_config[var.region]["internet"]
  intranet_cidr_config      = local.cidr_config[var.region]["intranet"]
}

module "nonprod" {
  source = "./vpc-module"

  region         = var.region
  vpc_id         = module.bootstrap.vpc_nonprod_id
  vpc_name       = module.bootstrap.vpc_nonprod_name
  rg_cloudops_id = module.bootstrap.rg_cloudops_id
}

module "internet" {
  source = "./vpc-module"

  region         = var.region
  vpc_id         = module.bootstrap.vpc_internet_id
  vpc_name       = module.bootstrap.vpc_internet_name
  rg_cloudops_id = module.bootstrap.rg_cloudops_id
}

module "intranet" {
  source = "./vpc-module"

  region         = var.region
  vpc_id         = module.bootstrap.vpc_intranet_id
  vpc_name       = module.bootstrap.vpc_intranet_name
  rg_cloudops_id = module.bootstrap.rg_cloudops_id
}

module "cloud-firewall" {
  source = "./shared/cloud-firewall"
}
