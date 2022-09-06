resource "kubernetes_config_map" config-terraform {
  metadata {
    name      = "${var.name}-terraform"
    namespace = var.namespace
  }

  data = var.data
}
