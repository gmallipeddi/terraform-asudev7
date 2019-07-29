resource "aws_iam_user" "user" {
  name = "${var.iam-user}"
}

resource "aws_iam_user_policy_attachment" "import_bucket" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "${var.cli-s3-access-arn}"
}

resource "aws_iam_user_policy_attachment" "manage_accesskey" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "${aws_iam_policy.ldw_manage_accesskeys.arn}"
}

resource "aws_iam_policy" "ldw_manage_accesskeys" {
  name        = "LDWManageAccessKeys_${var.iam-user}"
  description = "LDW Manage Access Keys access for user ${var.iam-user}"

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
                "arn:aws:iam::${var.current-account-id}:user/${var.iam-user}"
            ]
        }
    ]
}
EOF
}

