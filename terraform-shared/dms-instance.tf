resource "aws_dms_replication_subnet_group" "dms_subnetgroup" {
  replication_subnet_group_description = "dms replication group"
  replication_subnet_group_id          = "pm-dms-1"
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  subnet_ids = [module.vpc.private_ids]
  tags = merge(
    module.tags.tags,
    {
      "Name" = "${module.tags.tags["Lifecycle"]}-1"
    },
  )
}

resource "aws_dms_replication_instance" "instance" {
  count = var.dms_enabled

  auto_minor_version_upgrade   = true
  engine_version               = "3.1.4"
  multi_az                     = false
  preferred_maintenance_window = "fri:05:00-fri:05:30"
  publicly_accessible          = false
  replication_instance_class   = var.dms_instance_class
  replication_instance_id      = "pm-${var.tags["Lifecycle"]}-instance-1"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.dms_subnetgroup.id
  tags = merge(
    module.tags.tags,
    {
      "Name" = "${module.tags.tags["Lifecycle"]}-1"
    },
  )
  vpc_security_group_ids = [aws_security_group.dms-sg.id]
}

