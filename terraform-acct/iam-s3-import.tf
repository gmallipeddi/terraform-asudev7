resource "aws_iam_policy" "LDWRDSS3Integration" {
  name        = "LDWRDSS3Integration"
  description = "Allow RDS to read files in S3"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
       {
         "Sid": "s3integration",
         "Action": [
           "s3:GetObject",
           "s3:ListBucket",
           "s3:PutObject"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::oracle-data-warehouse-import", 
           "arn:aws:s3:::oracle-data-warehouse-import/*"
         ]
       }
    ]
}
EOF
}

resource "aws_iam_role" "LDWRDSS3Integration" {
  name        = "LDWRDSS3Integration"
  description = "Role forLDW RDS S3 bucket integration"

  assume_role_policy = <<EOF
{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
            "Service": "rds.amazonaws.com"
          },
         "Action": "sts:AssumeRole"
       }
     ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "LDWRDSS3Integration" {
  role       = "${aws_iam_role.LDWRDSS3Integration.name}"
  policy_arn = "${aws_iam_policy.LDWRDSS3Integration.arn}"
}
