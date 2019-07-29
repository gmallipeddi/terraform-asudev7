module "user-rbulusu" {
  source = "./iam-users"
  iam-user = "rbulusu"
  current-account-id = "${data.aws_caller_identity.current.account_id}"
  cli-s3-access-arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
}

module "user-mrball2" {
  source = "./iam-users"
  iam-user = "mrball2"
  current-account-id = "${data.aws_caller_identity.current.account_id}"
  cli-s3-access-arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
}

module "user-ssbhati3" {
  source = "./iam-users"
  iam-user = "ssbhati3"
  current-account-id = "${data.aws_caller_identity.current.account_id}"
  cli-s3-access-arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
}

module "user-mwsmit19" {
  source = "./iam-users"
  iam-user = "mwsmit19"
  current-account-id = "${data.aws_caller_identity.current.account_id}"
  cli-s3-access-arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
}

module "user-schinthi" {
  source = "./iam-users"
  iam-user = "schinthi"
  current-account-id = "${data.aws_caller_identity.current.account_id}"
  cli-s3-access-arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
}

module "user-avichenk" {
  source = "./iam-users"
  iam-user = "avichenk"
  current-account-id = "${data.aws_caller_identity.current.account_id}"
  cli-s3-access-arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
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
                "arn:aws:s3:::oracle-data-warehouse-import"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": [
                "arn:aws:s3:::oracle-data-warehouse-import/*"
            ]
        }
    ]
}
EOF
}
