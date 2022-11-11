provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "colima"
}
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "colima"
  }
}
