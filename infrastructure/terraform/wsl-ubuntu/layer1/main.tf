module "argocd" {
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
