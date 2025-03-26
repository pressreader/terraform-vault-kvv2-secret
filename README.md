# Terraform Vault KV V2 Secret Module

## Overview
This Terraform module provisions and manages secrets in **HashiCorp Vault KV v2**. 


- Supports custom metadata, including tracking with `managed_by` and module repository references.

## Usage
```hcl
module "vault_kvv_secret" {
  source = "git::https://github.com/pressreader/terraform-vault-kvv2-secret.git"

  name  = "my-secret"
  data  = { "username" = "admin", "password" = "supersecret" }
  mount = "kvv2"  # Optional, defaults to "kvv2"

  custom_metadata = {
    max_versions = 5
    data = {
      managed_by = "terraform"
      module     = "github.com/pressreader/terraform-vault-kvv2-secret"
    }
  }
}
```

## Inputs

| Name              | Type        | Default | Description |
|-------------------|------------|---------|-------------|
| `mount`          | `string`    | `"kvv2"` | Path where the KV v2 secrets engine is mounted. |
| `name`           | `string`    | **(Required)** | Name of the secret in Vault. |
| `data`           | `map(string)` | **(Required)** | Key-value pairs to store in the secret. |
| `custom_metadata` | `object`    | See Default | Metadata for the secret. Allows tracking ownership and module reference. |
| `delete_all`     | `bool`      | `false` | If `true`, deletes all versions of the secret. |
| `cas`            | `number`    | `null`  | Check-and-set (CAS) value for write operations. |
| `created_by`     | `string`    | **(Required)** | Identifies the creator of the secret. Merged into `custom_metadata.data`. |

### Default for `custom_metadata`
```hcl
custom_metadata = {
  data = {
    managed_by = "terraform"
    module     = "github.com/pressreader/terraform-vault-kvv2-secret"
  }
}
```

## Outputs

| Name   | Description |
|--------|-------------|
| `path` | Full path of the stored secret in Vault. |
| `metadata` | Metadata of the stored secret. |

## Notes
- Ensure that Vault authentication is properly configured for Terraform.
- Ensure `mount` (kvv2 by default) is already ready/mounted in Vault


