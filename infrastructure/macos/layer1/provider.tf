provider "kubernetes" {
  config_path            = "~/.kube/config"
  config_context_cluster = "colima"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
