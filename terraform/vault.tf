variable "vault_addr" {
  description = "URL of Vault Server"
}

variable "vault_token" {
  description = "Vault Token"
}

provider "vault" {
  address = "${var.vault_addr}"
  token   = "${var.vault_token}"
}

variable "vault_role_ttl" {
  default     = "3600"
  description = "The TTL of the Vault-created db credentials"
}

resource "vault_generic_secret" "rds_oracle_master" {
  path = "${pm_vault_path}"

  data_json = <<EOT
{
  "username":   "${var.pm_username}",
  "password":   "${random_string.pm_master_password.result}",
  "endpoint":   "${aws_db_instance.pm_ldw_oracle.endpoint}"
}
EOT
}
