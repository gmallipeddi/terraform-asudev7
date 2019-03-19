#admin_role_arn = "arn:aws:iam::640664498685:role/Jenkins"
admin_role_arn = "arn:aws:iam::640664498685:role/AdministratorAccessCLI"

tags = {
  ProductCategory   = "??"
  ProductFamily     = "??"
  Product           = "Data Warehouse"
  Lifecycle         = "non-prod"
  TechContact       = "??"
  AdminContact      = "??"
  BillingCostCenter = "??"
  BillingProgram    = "??"
  Repo              = "https://github.com/ASU/edw-oracle-data-warehouse"
}

vpc_name = "BINONPROD-us-west-2"

log_prefix = "rds/data-warehouse"

vault_role_ttl = "315360000"

region = "us-west-2"

identifier = "data-warehouse-oracle"

allocated_storage = 6000

storage_type = "gp2"

engine = "oracle-se2"

engine_version = "12.2.0.1.ru-2019-01.rur-2019-01.r1"

instance_class = "db.m5.4xlarge"

name = "ASUPMCLD"

username = "rdsadm"

license_model = "license-included"

character_set_name = "WE8ISO8859P15"

option_group_name = "default.oracle-se2-12-2"

deletion_protection = false

auto_minor_version_upgrade = false

backup_retention_period = 0

storage_encrypted = true

maintenance_window = "Fri:12:00-Fri:12:30"

copy_tags_to_snapshot = true

skip_final_snapshot = true

product_name = "oracle-data-warehouse"
