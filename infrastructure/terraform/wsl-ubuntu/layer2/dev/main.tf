resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.env
    labels = {
      "istio-injection" = "enabled"
    }
  }
}

locals {
  namespace = kubernetes_namespace.namespace.metadata[0].name
}

resource "kubernetes_manifest" "istio-geteway" {
  manifest = yamldecode(
    <<-EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: dynamicloading-gateway
  namespace: ${local.namespace}
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
    - port:
        number: 80
        name: grpc
        protocol: HTTP
      hosts:
        - "*"
EOF
  )
}

module "configmap" {
  source = "../../../modules/k8s-configmap"

  name      = "shared-configs"
  namespace = local.namespace

  data = {
    ENV          = var.env
    ENV_PROVIDER = var.env_provider
    ENV_LEVEL    = var.env_level
  }
}

module "product" {
  source     = "../../../modules/services/product"
  depends_on = [kubernetes_namespace.namespace]

  env       = var.env
  namespace = local.namespace
}

module "order" {
  source     = "../../../modules/services/order"
  depends_on = [kubernetes_namespace.namespace]

  env       = var.env
  namespace = local.namespace
}
