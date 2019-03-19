resource "aws_db_instance" "default" {
  identifier                 = "${var.identifier}"
  allocated_storage          = "${var.allocated_storage}"
  storage_type               = "${var.storage_type}"
  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"
  instance_class             = "${var.instance_class}"
  name                       = "${var.name}"
  username                   = "${var.username}"
  password                   = "${random_string.master_password.result}"
  character_set_name         = "${var.character_set_name}"
  license_model              = "${var.license_model}"
  vpc_security_group_ids     = ["${module.rds-sg.id}"]
  db_subnet_group_name       = "${aws_db_subnet_group.subnet_group.id}"
  backup_retention_period    = "${var.backup_retention_period}"
  skip_final_snapshot        = "${var.skip_final_snapshot}"
  option_group_name          = "${var.option_group_name}"
  deletion_protection        = "${var.deletion_protection}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  storage_encrypted          = "${var.storage_encrypted}"
  maintenance_window         = "${var.maintenance_window}"
  copy_tags_to_snapshot      = "${var.copy_tags_to_snapshot}"
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "${var.identifier}-subnet-group"
  description = "${var.identifier} RDS Subnet Group"

  subnet_ids = ["${module.vpc.private_ids}"]
}

resource "random_string" "master_password" {
  length  = 16
  special = "false"
}
