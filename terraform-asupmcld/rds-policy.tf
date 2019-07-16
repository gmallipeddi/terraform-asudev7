resource "aws_iam_policy" "allow_snapshots_role_policy" {
  name        = "RDSAllowSnapshots"
  description = "Role policy for Allowing DBAs to manipulate snapshots"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowSnapshots",
            "Effect": "Allow",
            "Action": [
                "rds:CreateDBSnapshot",
                "rds:CopyDBSnapshot",
                "rds:DeleteDBSnapshot"
            ],
            "Resource": [
                "${aws_db_instance.pm_ldw_oracle.arn}",
                "${var.pm_snapshot_arn}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "rds_allow_snapshots_policy_attach" {
  role       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/RDSReadOnlyWithSnapshots"
  policy_arn = "${aws_iam_policy.allow_snapshots_role_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "rds_dba_policy_attach" {
  role       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/RDSReadOnlyWithSnapshots"
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

# this is no longer needed but kept tempararily as a memory aid.
#resource "aws_iam_role_policy_attachment" "ldw_iam_policy_attach" {
#  role       = "${aws_iam_role.rds_dba_role.name}"
#  policy_arn = "${aws_iam_policy.ldw_manage_accesskeys_rbulusu.arn}"
#}

data "aws_iam_policy_document" "allow_pi_access" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:pi:*:${data.aws_caller_identity.current.account_id}:metrics/rds/${var.pm_identifier}"]
    actions   = ["pi:*"]
  }
}

resource "aws_iam_policy" "ldw_allow_pi" {
  name        = "RDSDBAAllowPI"
  description = "RDS DBA Allow Performance Insights Access"
  policy      = "${data.aws_iam_policy_document.allow_pi_access.json}"
}

resource "aws_iam_role_policy_attachment" "ldw_allow_pi_policy_attach" {
  role       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/RDSReadOnlyWithSnapshots"
  policy_arn = "${aws_iam_policy.ldw_allow_pi.arn}"
}
