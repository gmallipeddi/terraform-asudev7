resource "aws_iam_user" "user" {
  name = var.iam_user
}

resource "aws_iam_user_policy_attachment" "import_bucket" {
  user       = aws_iam_user.user.name
  policy_arn = var.cli_s3_access_arn
}

resource "aws_iam_user_policy_attachment" "manage_accesskey" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.ldw_manage_accesskeys.arn
}

resource "aws_iam_policy" "ldw_manage_accesskeys" {
  name        = "LDWManageAccessKeys_${var.iam_user}"
  description = "LDW Manage Access Keys access for user ${var.iam_user}"

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
                "arn:aws:iam::${var.current_account_id}:user/${var.iam_user}"
            ]
        }
    ]
}
EOF

}

