resource "kubernetes_namespace" "namespace" {
  metadata {
    name   = var.namespace
    labels = {
      "istio-injection" = "enabled"
    }
  }
}

locals {
  namespace = kubernetes_namespace.namespace.metadata[0].name
}

resource "kubernetes_manifest" "istio-gateway" {
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
    ENV       = var.env
    PLATFORM  = var.platform
    NAMESPACE = local.namespace
  }
}

module "product" {
  source = "../../../../services/product/terraform"

  env       = var.env
  namespace = local.namespace
}

module "order" {
  source = "../../../../services/order/terraform"

  env       = var.env
  namespace = local.namespace
}
