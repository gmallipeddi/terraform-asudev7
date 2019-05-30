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
    "129.219.42.64/26",   # Linux DEV/QA Web Servers
    "129.219.134.0/24",   # Linux DEV/QA Web/App Servers
    "10.106.226.0/24",    # Linux DEV/QA Web/App Servers
    "10.106.229.0/24",    # Linux DEV/QA Web/App Servers
    "10.106.230.0/24",    # Linux DEV/QA Web Servers
    "129.219.134.0/25",   # Linux DEV/QA Web Servers
    "129.219.29.0/24",    # Linux DEV/QA Web Servers
    "10.106.225.0/24",    # ControlM Servers
    "10.106.226.0/24",    # MuleSoft Servers
    "10.120.128.0/23",    # BI Desktops
    "10.120.130.0/23",    # BI Desktops
    "10.120.160.0/21",    # BI Desktops
    "10.120.168.0/21",    # BI Desktops
    "10.120.114.0/24",    # Alteryx
    "10.120.115.0/24",    # DataStage nprod
    "10.220.132.203/32",  # Tableau (AWS UoA)
    "172.24.46.0/24",     # MSBI nprod (SCI)
    "172.25.46.0/24",     # Hyperion nprod (SCI)
    "129.219.103.86/32",  # ssis-n1.asurite.ad.asu.edu
    "129.219.176.25/32",  # dba-ts.asurite.ad.asu.edu
    "10.107.105.237/32",  # ssis-1.prod.ms.asu.edu
    "10.107.105.156/32",  # uto-dba-ts.prod.ms.asu.edu
    "10.107.105.171/32",  # uto-dba-ts2.prod.ms.asu.edu
    "10.120.110.100/32",  # ssis-2.prod.ms.asu.edu
  ] # oracle-in
}
