resource "aws_db_instance" "pm_ldw_oracle" {
  identifier                 = "${var.pm_identifier}"
  allocated_storage          = "${var.pm_allocated_storage}"
  storage_type               = "${var.pm_storage_type}"
  engine                     = "${var.pm_engine}"
  engine_version             = "${var.pm_engine_version}"
  instance_class             = "${var.pm_instance_class}"
  name                       = "${var.pm_name}"
  username                   = "${var.pm_username}"
  password                   = "${random_string.pm_master_password.result}"
  character_set_name         = "${var.pm_character_set_name}"
  license_model              = "${var.pm_license_model}"
  vpc_security_group_ids     = ["${module.rds-sg.id}"]
  db_subnet_group_name       = "${aws_db_subnet_group.pm_subnet_group.id}"
  backup_retention_period    = "${var.pm_backup_retention_period}"
  skip_final_snapshot        = "${var.pm_skip_final_snapshot}"
  option_group_name          = "${var.pm_option_group_name}"
  deletion_protection        = "${var.pm_deletion_protection}"
  auto_minor_version_upgrade = "${var.pm_auto_minor_version_upgrade}"
  storage_encrypted          = "${var.pm_storage_encrypted}"
  maintenance_window         = "${var.pm_maintenance_window}"
  copy_tags_to_snapshot      = "${var.pm_copy_tags_to_snapshot}"
  tags                       = "${merge(var.tags, map("Name", "${var.pm_identifier}"))}"
}

resource "aws_db_subnet_group" "pm_subnet_group" {
  name        = "${var.pm_identifier}-subnet-group"
  description = "${var.pm_identifier} RDS Subnet Group"

  subnet_ids = ["${module.vpc.private_ids}"]
}

resource "random_string" "pm_master_password" {
  length  = 16
  special = "false"
}
