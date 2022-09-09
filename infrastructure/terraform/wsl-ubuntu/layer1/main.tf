
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
  depends_on = [module.argocd_self_managed_helm]

  metadata {
    name      = "argocd-ingress"
    namespace = "argocd"
  }

  spec {
    rule {
      host = "argocd.wsl-ubuntu.anddd7.io"
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
      hosts       = ["argocd.wsl-ubuntu.anddd7.io"]
      secret_name = "argocd-secret"
    }
  }
}
