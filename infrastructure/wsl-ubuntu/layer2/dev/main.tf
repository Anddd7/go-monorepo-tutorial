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
    ENV       = var.env
    NAMESPACE = var.namespace
    PLATFORM  = var.platform
  }
}

module "product" {
  source     = "../../../../services/product/terraform"
  depends_on = [kubernetes_namespace.namespace]

  env       = var.env
  namespace = var.namespace
}

module "order" {
  source     = "../../../../services/order/terraform"
  depends_on = [kubernetes_namespace.namespace]

  env       = var.env
  namespace = var.namespace
}
