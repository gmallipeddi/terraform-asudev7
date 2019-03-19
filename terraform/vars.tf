variable "vpc_name" {}

variable "ssh_user" {
  default = "ec2-user"
}

variable "allocated_storage" {}
variable "storage_type" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "name" {}
variable "username" {}
variable "identifier" {}
variable "license_model" {}
variable "character_set_name" {}
variable "backup_retention_period" {}
variable "deletion_protection" {}
variable "storage_encrypted" {}
variable "option_group_name" {}
variable "auto_minor_version_upgrade" {}
variable "maintenance_window" {}
variable "copy_tags_to_snapshot" {}
variable "skip_final_snapshot" {}

variable "log_prefix" {}
variable "product_name" {}
