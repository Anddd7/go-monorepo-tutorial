module "configmap" {
  source = "../../../infrastructure/modules/k8s-configmap"

  name      = "order"
  namespace = var.namespace
}
