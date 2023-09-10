locals {
  user_list = yamldecode(file("./user-list.yaml"))
}


module "iam_alicloud" {
  source = "../modules/alicloud/iam"

  user_list = local.user_list
}

module "iam_gcp" {
  source = "../modules/gcp/iam"

  user_list = local.user_list
}
