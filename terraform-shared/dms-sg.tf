resource "aws_security_group" "dms-sg" {
  name        = "${module.vpc.name}-dms"
  description = "${module.vpc.name} DMS"
  vpc_id      = module.vpc.id
  tags = merge(
    module.tags.tags,
    {
      "Name" = "${module.vpc.name}-dms"
    },
  )
  # tags = merge(
  #   module.tags.tags,
  #   {
  #     "Name" = "${module.vpc.name}-dms"
  #   },
  # )
}

# resource "aws_security_group_rule" "dms_oracle_local_out" {
#   type        = "egress"
#   description = "Oracle (VPC)"
#   from_port   = 3200
#   to_port     = 3200
#   protocol    = "tcp"

#   cidr_blocks = module.vpc.private_cidrs

#   security_group_id = aws_security_group.dms-sg.id
# }

resource "aws_security_group_rule" "dms_oracle_sci_out" {
  type        = "egress"
  description = "Oracle (SCI)"
  from_port   = 3200
  to_port     = 3200
  protocol    = "tcp"

  cidr_blocks = [
    "172.25.48.43/32", # dblx501-vip2
    "172.25.48.45/32", # dblx502-vip2
    "172.25.48.44/32", # dblx501-vip3
    "172.25.48.46/32", # dblx502-vip3
  ]

  security_group_id = aws_security_group.dms-sg.id
}

resource "aws_security_group_rule" "dms_oracle_private_out" {
  type        = "egress"
  description = "Oracle (Private VPC)"
  from_port   = 3200
  to_port     = 3200
  protocol    = "tcp"

  cidr_blocks = module.vpc.private_cidrs

  security_group_id = aws_security_group.dms-sg.id
}

