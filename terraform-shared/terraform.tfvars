admin_role_arn = "arn:aws:iam::640664498685:role/Jenkins"

region = "us-west-2"

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

dms_enabled        = 1
dms_instance_class = "dms.c4.xlarge"
