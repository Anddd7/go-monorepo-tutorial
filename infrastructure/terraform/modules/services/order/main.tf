module "configmap" {
  source = "../../k8s-configmap"

  name      = "order"
  namespace = "${var.env}-ns"
}
