module "rds-sg" {
  source = "git::ssh://git@github.com/ASU/dco-terraform.git//modules/security-group"

  name        = "${var.pm_name}"
  description = "RDS ${var.pm_name} - Oracle"

  vpc_name = "${var.vpc_name}"

  tags = "${var.tags}"
}

resource "aws_security_group_rule" "oracle-in" {
  security_group_id = "${module.rds-sg.id}"
  type              = "ingress"
  description       = "${var.pm_name} db"
  from_port         = 1521
  to_port           = 1521
  protocol          = "tcp"

  cidr_blocks = [
    "129.219.229.128/25",
    "172.31.16.0/20",
    "172.31.32.0/20",
  ] # oracle-in
}
