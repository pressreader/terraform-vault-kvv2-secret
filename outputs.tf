output "main" {
  value = {
    id       = vault_kv_secret_v2.secret.id
    path     = vault_kv_secret_v2.secret.name
    metadata = vault_kv_secret_v2.secret.custom_metadata
  }
}
