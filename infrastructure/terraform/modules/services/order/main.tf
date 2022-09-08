module "configmap" {
  source = "../../k8s-configmap"

  name      = "order"
  namespace = "${var.env}-ns"
  data      = {
    ENV = var.env
  }
}
