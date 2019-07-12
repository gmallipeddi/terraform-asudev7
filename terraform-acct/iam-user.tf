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

resource "aws_iam_user_policy_attachment" "rbulusu_import_bucket" {
  user       = "${aws_iam_user.rbulusu.name}"
  policy_arn = "${aws_iam_policy.dba_cli_s3_access.arn}"
}

resource "aws_iam_policy" "ldw_manage_accesskeys_rbulusu" {
  name        = "LDWManageAccessKeys_rbulusu"
  description = "LDW Manage Access Keys access for user rbulusu"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateAccessKey",
                "iam:DeleteAccessKey",
                "iam:GetAccessKeyLastUsed",
                "iam:ListAccessKeys",
                "iam:UpdateAccessKey",
                "iam:GetUser",
                "iam:GetAccountSummary",
                "iam:ListAccountAliases",
                "iam:ListUsers"
            ],
            "Resource": [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/rbulusu"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "rbulusu_manage_accesskey" {
  user       = "${aws_iam_user.rbulusu.name}"
  policy_arn = "${aws_iam_policy.ldw_manage_accesskeys_rbulusu.arn}"
}
