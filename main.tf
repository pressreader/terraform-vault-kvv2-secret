# resource "vault_mount" "kv" {
#   path        = var.mount
#   type        = "kv"
#   options     = { version = "2" }
#   description = "KV Version 2 secret engine mount"
# }

locals {
  # Merging the created_by value into the custom_metadata data
  merged_metadata_data = merge(
    var.custom_metadata.data,
    {
      created_by = var.created_by
    }
  )
}


resource "vault_kv_secret_v2" "secret" {

  mount     = var.mount
  name      = var.name
  data_json = jsonencode(var.data)
  cas       = var.cas

  delete_all_versions = var.delete_all_versions
  dynamic "custom_metadata" {
    for_each = var.custom_metadata != null ? [var.custom_metadata] : []

    content {
      max_versions = lookup(custom_metadata.value, "max_versions", null)

      data = local.merged_metadata_data
    }
  }


}
