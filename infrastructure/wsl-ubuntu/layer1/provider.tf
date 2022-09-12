provider "kubernetes" {
  config_path            = "~/.kube/config"
  config_context_cluster = "minikube"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
