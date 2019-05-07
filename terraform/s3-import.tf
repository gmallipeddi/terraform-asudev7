resource "aws_s3_bucket" "import_bucket" {
  bucket = "oracle-data-warehouse-import"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = "${merge(var.tags, map("Name", "oracle-data-warehouse-import"))}"
}
