resource "aws_s3_bucket" "import_bucket" {
  bucket = "oracle-data-warehouse-import"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = "oracle-data-warehouse-import"
    },
  )
}

data "aws_iam_policy_document" "import_bucket" {
  statement {
    sid = "s3integration_bp"

    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]

    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::306276705765:root"]
    }

    resources = [
      "arn:aws:s3:::oracle-data-warehouse-import",
      "arn:aws:s3:::oracle-data-warehouse-import/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "import_bucket" {
  bucket = aws_s3_bucket.import_bucket.id

  policy = data.aws_iam_policy_document.import_bucket.json
}
