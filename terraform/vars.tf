variable "vpc_name" {}
variable "log_prefix" {}

variable "pm_storage_type" {}
variable "pm_engine" {}
variable "pm_storage_encrypted" {}
variable "pm_copy_tags_to_snapshot" {}
variable "pm_allocated_storage" {}
variable "pm_engine_version" {}
variable "pm_instance_class" {}
variable "pm_name" {}
variable "pm_username" {}
variable "pm_identifier" {}
variable "pm_license_model" {}
variable "pm_character_set_name" {}
variable "pm_backup_retention_period" {}
variable "pm_deletion_protection" {}
variable "pm_option_group_name" {}
variable "pm_major_engine_version" {}
variable "pm_auto_minor_version_upgrade" {}
variable "pm_maintenance_window" {}
variable "pm_skip_final_snapshot" {}

variable "pm_apply_immediately" {
  default = false
}
