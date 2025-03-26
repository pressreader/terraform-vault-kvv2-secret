locals {
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
      max_versions = var.max_versions

      data = local.merged_metadata_data
    }
  }


}
