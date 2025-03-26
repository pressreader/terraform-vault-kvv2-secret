resource "vault_mount" "kv" {
  path        = var.mount
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "secret" {
  mount      = vault_mount.kv.path
  name       = var.name
  data_json  = jsonencode(var.data)
  cas        = var.cas
  delete_all = var.delete_all
  dynamic "metadata" {
    for_each = var.custom_metadata != null ? [var.custom_metadata] : []

    content {
      max_versions = lookup(metadata.value, "max_versions", null)

      data = lookup(metadata.value, "data", {})
    }
  }


}
