#admin_role_arn = "arn:aws:iam::640664498685:role/Jenkins"
admin_role_arn = "arn:aws:iam::640664498685:role/AdministratorAccessCLI"

tags = {
  ProductCategory   = "Business Intelligence"
  ProductFamily     = "Enterprise Data Warehouse"
  Product           = "Legacy Data Warehouse"
  Lifecycle         = "non-prod"
  TechContact       = "tford6"
  AdminContact      = "khssb"
  BillingCostCenter = "CC0815"
  BillingProgram    = "PG06101"
  Repo              = "https://github.com/ASU/edw-oracle-data-warehouse"
}

vpc_name = "BINONPROD-us-west-2"

log_prefix = "rds/legacy-data-warehouse"

region = "us-west-2"

pm_storage_type = "gp2"

pm_engine = "oracle-se2"

pm_storage_encrypted = true

pm_copy_tags_to_snapshot = true

pm_identifier = "legacy-data-warehouse-oracle"

pm_allocated_storage = 6000

pm_engine_version = "12.2.0.1.ru-2019-01.rur-2019-01.r1"

pm_instance_class = "db.m5.4xlarge"

pm_name = "ASUPMCLD"

pm_username = "rdsadm"

pm_license_model = "license-included"

pm_character_set_name = "WE8ISO8859P15"

pm_option_group_name = ""

pm_deletion_protection = false

pm_auto_minor_version_upgrade = false

pm_backup_retention_period = 0

pm_maintenance_window = "Fri:12:00-Fri:12:30"

pm_skip_final_snapshot = true
