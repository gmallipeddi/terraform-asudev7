resource "aws_iam_user" "rbulusu" {
  name = "rbulusu"
}

resource "aws_iam_policy" "dba_cli_s3_access" {
  name        = "LDWDBAS3access"
  description = "LDW DBA S3 bucket access for Oracle import"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload"
            ],
            "Resource": [
                "${aws_s3_bucket.import_bucket.arn}"
            ]
        }
    ],
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": [
                "${aws_s3_bucket.import_bucket.arn}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "rbulusu_import_bucket" {
  user       = "${aws_iam_user.rbulusu.name}"
  policy_arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
}
