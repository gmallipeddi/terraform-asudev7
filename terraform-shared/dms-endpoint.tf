resource "random_string" "dms_temp_password" {
  length  = 16
  special = false
}

resource "aws_dms_endpoint" "asupmcld" {
  endpoint_id   = "asupmcld"
  endpoint_type = "target"
  engine_name   = "oracle"
  port          = 1521
  ssl_mode      = "verify-ca"

  server_name   = "asupmcld.cslew3xddqer.us-west-2.rds.amazonaws.com"
  database_name = "ASUPMCLD"
  username      = "username"
  password      = "${random_string.dms_temp_password.result}"

  tags = "${module.tags.tags}"

  lifecycle {
    ignore_changes = ["password"]
  }
}

resource "aws_dms_endpoint" "asupmtst" {
  endpoint_id   = "asupmtst"
  endpoint_type = "source"
  engine_name   = "oracle"
  port          = 3200
  ssl_mode      = "verify-ca"

  database_name = "ASUPMTST"
  server_name   = "172.25.48.43"                              # dblx501-vip2.atsc.asu.edu
  username      = "sysadm"
  password      = "${random_string.dms_temp_password.result}"

  tags = "${module.tags.tags}"

  lifecycle {
    ignore_changes = ["password"]
  }
}
