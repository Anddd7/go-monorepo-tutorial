output "output_name" {
  value = format(
    "%s/%s",
    kubernetes_config_map.config-terraform.metadata.namespace,
    kubernetes_config_map.config-terraform.metadata.name,
  )
}
