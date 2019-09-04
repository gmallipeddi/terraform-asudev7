resource "aws_dms_replication_task" "task_sample" {
  count = var.dms_enabled

  migration_type           = "full-load"
  replication_instance_arn = aws_dms_replication_instance.instance[0].replication_instance_arn
  replication_task_id      = "sample"
  source_endpoint_arn      = aws_dms_endpoint.asupmtst.endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.asupmcld.endpoint_arn

  replication_task_settings = file("dms-task-default-settings.json")
  table_mappings            = file("dms-task-mappings.json")

  tags = module.tags.tags
}

