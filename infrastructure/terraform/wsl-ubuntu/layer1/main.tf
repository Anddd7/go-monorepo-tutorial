
module "argocd_self_managed_helm" {
  source = "lablabs/argocd/helm"

  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  self_managed = false

  helm_release_name = "argocd"
  namespace         = "argocd"

  helm_timeout = 240
  helm_wait    = true
}

resource "kubernetes_ingress_v1" "argocd-ingress" {
  metadata {
    name      = "argocd-ingress"
    namespace = "argocd"
    annotations = {
      # "kubernetes.io/ingress.class" = "nginx"
      # "nginx.ingress.kubernetes.io/force-ssl-redirect" = true
      # "nginx.ingress.kubernetes.io/ssl-passthrough"  = "true"
      # "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
    }
  }

  spec {
    rule {
      host = "argocd.192.168.49.2.xip.io"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "argocd-server"
              port {
                name = "https"
              }
            }
          }
        }
      }
    }
    tls {
      hosts       = ["argocd.192.168.49.2.xip.io"]
      secret_name = "argocd-secret"
    }
  }
}
