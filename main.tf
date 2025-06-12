resource "vault_kv_secret_v2" "secret" {
  mount     = var.mount
  name      = var.name
  data_json = jsonencode(var.data)
  cas       = var.cas

  delete_all_versions = var.delete_all_versions

  custom_metadata {
    max_versions = var.max_versions
    data         = var.custom_metadata.data
  }
}
