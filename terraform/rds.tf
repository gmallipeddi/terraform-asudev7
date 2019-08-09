resource "aws_db_instance" "pm_ldw_oracle" {
  identifier                   = "${var.pm_identifier}"
  allocated_storage            = "${var.pm_allocated_storage}"
  max_allocated_storage        = "${var.pm_max_allocated_storage}"
  storage_type                 = "${var.pm_storage_type}"
  engine                       = "${var.pm_engine}"
  engine_version               = "${var.pm_engine_version}"
  instance_class               = "${var.pm_instance_class}"
  name                         = "${var.pm_name}"
  username                     = "${var.pm_username}"
  password                     = "${random_string.pm_master_password.result}"
  character_set_name           = "${var.pm_character_set_name}"
  license_model                = "${var.pm_license_model}"
  vpc_security_group_ids       = ["${module.rds-sg.id}"]
  db_subnet_group_name         = "${aws_db_subnet_group.pm_subnet_group.id}"
  backup_retention_period      = "${var.pm_backup_retention_period}"
  backup_window                = "${var.pm_backup_window}"
  skip_final_snapshot          = "${var.pm_skip_final_snapshot}"
  option_group_name            = "${aws_db_option_group.pm_ldw_oracle.name}"
  deletion_protection          = "${var.pm_deletion_protection}"
  auto_minor_version_upgrade   = "${var.pm_auto_minor_version_upgrade}"
  storage_encrypted            = "${var.pm_storage_encrypted}"
  maintenance_window           = "${var.pm_maintenance_window}"
  copy_tags_to_snapshot        = "${var.pm_copy_tags_to_snapshot}"
  tags                         = "${merge(var.tags, map("Name", "${var.pm_identifier}"))}"
  apply_immediately            = "${var.pm_apply_immediately}"
  parameter_group_name         = "${aws_db_parameter_group.pm_ldw_oracle_parameters.name}"
  performance_insights_enabled = "true"

  enabled_cloudwatch_logs_exports = [
    "alert",
    "audit",
    "listener",
    "trace",
  ]
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

resource "aws_db_option_group" "pm_ldw_oracle" {
  name                     = "${var.pm_identifier}-${var.pm_engine}-${replace(var.pm_major_engine_version, ".", "-")}"
  option_group_description = "${var.pm_identifier} PL LDW Oracle"
  engine_name              = "${var.pm_engine}"
  major_engine_version     = "${var.pm_major_engine_version}"
  tags                     = "${merge(var.tags, map("Name", "${var.pm_identifier}-${var.pm_engine}-${replace(var.pm_major_engine_version, ".", "-")}"))}"

  option {
    option_name = "NATIVE_NETWORK_ENCRYPTION"

    option_settings {
      name  = "SQLNET.ENCRYPTION_SERVER"
      value = "REQUIRED"
    }

    option_settings {
      name  = "SQLNET.CRYPTO_CHECKSUM_SERVER"
      value = "REQUIRED"
    }

    option_settings {
      name  = "SQLNET.ENCRYPTION_TYPES_SERVER"
      value = "AES256"
    }

    option_settings {
      name  = "SQLNET.CRYPTO_CHECKSUM_TYPES_SERVER"
      value = "SHA256"
    }
  }

  option {
    option_name = "S3_INTEGRATION"
    version     = "1.0"
  }

  option {
    option_name = "Timezone"

    option_settings {
      name  = "TIME_ZONE"
      value = "America/Phoenix"
    }
  }
}

resource "aws_db_instance_role_association" "pm_ldw_oracle" {
  db_instance_identifier = "${aws_db_instance.pm_ldw_oracle.id}"
  feature_name           = "S3_INTEGRATION"
  role_arn               = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LDWRDSS3Integration"
}

resource "aws_db_parameter_group" "pm_ldw_oracle_parameters" {
  name        = "${var.pm_identifier}-${var.pm_engine}-${replace(var.pm_major_engine_version, ".", "-")}"
  description = "RDS ${var.pm_identifier} parameters group"
  family      = "${var.pm_parameter_group_family}"
  tags        = "${merge(var.tags, map("Name", "${var.pm_identifier}-${var.pm_engine}-${replace(var.pm_major_engine_version, ".", "-")}"))}"

  parameter {
    name         = "max_string_size"
    value        = "EXTENDED"
    apply_method = "pending-reboot"
  }
}
