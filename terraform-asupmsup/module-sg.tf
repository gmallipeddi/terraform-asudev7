module "rds-sg" {
  source = "git::ssh://git@github.com/ASU/dco-terraform.git//modules/security-group?ref=0.12"

  name        = var.pm_name
  description = "RDS ${var.pm_name} - Oracle"

  vpc_name = var.vpc_name

  tags = var.tags
}

resource "aws_security_group_rule" "oracle-in" {
  security_group_id = module.rds-sg.id
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
    "10.106.250.0/24",    # Linux DEV/QA Web Servers
    "129.219.29.0/24",    # Linux DEV/QA Web Servers
    "10.106.225.0/24",    # ControlM Servers
    "10.120.128.0/23",    # BI Desktops
    "10.120.130.0/23",    # BI Desktops
    "10.120.160.0/21",    # BI Desktops
    "10.120.168.0/21",    # BI Desktops
    "10.120.114.0/24",    # Alteryx
    "10.120.115.0/24",    # DataStage nprod
    "10.220.132.203/32",  # Tableau (AWS UoA)
    "172.24.46.0/24",     # MSBI nprod (SCI)
    "172.25.46.0/24",     # Hyperion nprod (SCI)
    "172.25.50.0/24",     # SCI VPN NAT
    "129.219.103.86/32",  # ssis-n1.asurite.ad.asu.edu
    "129.219.176.25/32",  # dba-ts.asurite.ad.asu.edu
    "10.107.104.0/22",    # Illumio Windows Prod
    "10.120.110.100/32",  # ssis-2.prod.ms.asu.edu
    "129.219.23.0/24",    # biomssql.asurite.ad.asu.edu
    "129.219.73.0/24",    # hida-lw04.hida.asu.edu
    "129.219.84.0/24",    # Internal.biodesign.asu.edu
    "129.219.113.0/24",   # mailadmin.asu.edu
    "129.219.245.0/24",   # fdm-web.asurite.ad.asu.edu
    "10.107.44.0/24",     # btswapp.asurite.ad.asu.edu
    "10.107.47.0/24",     # new-doc-agntdev1.asu.edu
    "10.107.49.0/24",     # healthsol-dev2.asurite.ad.asu.edu
    "10.106.3.0/24",      # tb-dbamp-dev.asurite.ad.asu.edu
    "10.106.10.0/24",     # chem-webtools-dev.asu.edu
    "129.219.31.26/32",   # law-db.law.asu.edu
    "10.16.62.0/24",      # law-db1.law.asu.edu
    "10.119.11.0/24",     # wpcsql02.wpcarey.ad.asu.edu
    "10.192.2.0/24",      # authdev.lib.asu.edu
    "129.219.247.61/32",  # libfwcl.asu.edu
    "149.169.121.0/24",   # fultondevfw.fulton.ad.asu.edu
    "149.169.137.0/24",   # warehouse.asufoundation.org
    "10.120.16.0/23",     # ENTNONPROD Private VPC
    "10.120.18.0/23",     # ENTNONPROD Private VPC
    "10.120.20.0/23",     # ENTNONPROD Private VPC
    "172.25.50.148/32",   # asuasd01 SCI NAT IP
    "172.25.50.124/32",   # asuasd30 SCI NAT IP
    "172.25.50.125/32",   # asuasd31 SCI NAT IP
    "172.25.50.129/32",   # asuasp19 SCI NAT IP
    "172.25.50.102/32",   # asudbd20 SCI NAT IP
    "172.25.50.104/32",   # asudbd20b SCI NAT IP
    "172.25.50.105/32",   # asudbd20c SCI NAT IP
    "172.25.50.106/32",   # asudbd20-ba SCI NAT IP
    "172.25.50.109/32",   # asudbd20-bt SCI NAT IP
  ]                       # oracle-in
}

