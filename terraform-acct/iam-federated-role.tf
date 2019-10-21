resource "aws_iam_role" "rds_dba_role" {
  name        = "RDSReadOnlyWithSnapshots"
  description = "AssumeRole for DBAs RDS access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:saml-provider/shibboleth2"
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

resource "aws_iam_role_policy_attachment" "rds_dba_policy_attach" {
  role       = "RDSReadOnlyWithSnapshots"
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}
