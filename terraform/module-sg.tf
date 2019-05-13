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
    "129.219.229.128/25", # Linux VDIs
    "172.31.16.0/20",     # Prod SSLVPN
    "172.31.32.0/20",     # Prod SSLVPN
    "172.25.48.65/32",    # asudbdlx01a.mycmsc.com Sierra Cedar RAC node
    "172.25.48.67/32",    # asudbdlx01b.mycmsc.com Sierra Cedar RAC node
    "172.25.48.69/32",    # asudbdlx01c.mycmsc.com Sierra Cedar RAC node
    "172.25.48.71/32",    # asudbdlx01d.mycmsc.com Sierra Cedar RAC ndoe
    "129.219.7.64/26",    # Linux DEV/QA Web Servers
    "129.219.42.64/26",    # Linux DEV/QA Web Servers
    "129.219.134.0/24",    # Linux DEV/QA Web/App Servers
    "10.106.226.0/24",    # Linux DEV/QA Web/App Servers
    "10.106.229.0/24",    # Linux DEV/QA Web/App Servers
    "10.106.230.0/24",    # Linux DEV/QA Web Servers
  ] # oracle-in
}
