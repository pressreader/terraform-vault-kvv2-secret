variable "mount" {
  description = "Path where the KV v2 secrets engine is mounted. Defaults to 'kvv2'."
  type        = string
  default     = "kvv2"
}

variable "name" {
  description = "Name of the secret to store in Vault."
  type        = string
}

variable "data" {
  description = "Key-value pairs to store in the secret."
  type        = map(string)
}

variable "max_versions" {
  description = "Custom metadata max_versions of this secret"
  type        = number
  default     = 1
}
variable "custom_metadata" {
  description = <<EOT
  <br><b>max_versions:</b> maximum number of versions, by default 1.
  <br><b>data:</b> A managed map of how it was created, and merges created_by
EOT
  type = object({
    max_versions = optional(number)
    data         = optional(map(string), { managed_by = "terraform", module = "https://github.com/pressreader/terraform-vault-kvv2-secret" })
  })
  default = {
    max_versions = 1
    data = {
      managed_by = "terraform"
      created_by = "https://github.com/pressreader/terraform-vault-kvv2-secret"
    }
  }
}

variable "delete_all_versions" {
  description = "If true, deletes all versions of the secret."
  type        = bool
  default     = false
}

variable "cas" {
  description = "Check-and-set (CAS) value for write operations."
  type        = number
  default     = null
}
