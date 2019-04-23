resource "aws_iam_role" "rds_dba_role" {
  name        = "RDSDBARole"
  description = "AssumeRole for DBAs RDS access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::640664498685:saml-provider/shibboleth2"
      },
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
}

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
                "arn:aws:rds:us-west-2:640664498685:db:asupmcld"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "rds_allow_snapshots_policy_attach" {
  role       = "${aws_iam_role.rds_dba_role.name}"
  policy_arn = "${aws_iam_policy.allow_snapshots_role_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "rds_dba_policy_attach" {
  role       = "${aws_iam_role.rds_dba_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}
