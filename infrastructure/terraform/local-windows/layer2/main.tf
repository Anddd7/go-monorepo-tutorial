resource "kubernetes_namespace" "my-first-terraform-namespace" {
  metadata {
    name = "my-first-terraform-namespace"
  }
}
