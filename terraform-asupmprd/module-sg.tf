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
    "172.25.48.65/32",    # asudbdlx01a.mycmsc.com Sierra Cedar RAC node
    "172.25.48.67/32",    # asudbdlx01b.mycmsc.com Sierra Cedar RAC node
    "172.25.48.69/32",    # asudbdlx01c.mycmsc.com Sierra Cedar RAC node
    "172.25.48.71/32",    # asudbdlx01d.mycmsc.com Sierra Cedar RAC ndoe
    "10.106.225.0/24",    # ControlM Servers
    "10.120.128.0/23",    # BI Desktops
    "10.120.130.0/23",    # BI Desktops
    "10.120.160.0/21",    # BI Desktops
    "10.120.168.0/21",    # BI Desktops
    "10.120.114.0/24",    # Alteryx
    "10.120.115.0/24",    # DataStage nprod
    "10.120.116.0/24",    # DataStage
    "10.120.117.0/24",    # BIProd
    "10.220.132.203/32",  # Tableau (AWS UoA)
    "172.24.46.0/24",     # MSBI nprod (SCI)
    "172.25.46.0/24",     # Hyperion nprod (SCI)
    "129.219.103.86/32",  # ssis-n1.asurite.ad.asu.edu
    "129.219.176.25/32",  # dba-ts.asurite.ad.asu.edu
    "10.107.105.237/32",  # ssis-1.prod.ms.asu.edu
    "10.107.105.156/32",  # uto-dba-ts.prod.ms.asu.edu
    "10.107.105.171/32",  # uto-dba-ts2.prod.ms.asu.edu
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
    "172.25.50.65/32",    # asudbdlx01a SCI NAT IP
    "172.25.50.67/32",    # asudbdlx01b SCI NAT IP
    "172.25.50.69/32",    # asudbdlx01c SCI NAT IP
    "172.25.50.71/32",    # asudbdlx01d SCI NAT IP
    "172.25.50.73/32",    # asudbplx01a SCI NAT IP
    "172.25.50.75/32",    # asudbplx01b SCI NAT IP
    "172.25.50.77/32",    # asudbplx01c SCI NAT IP
    "172.25.50.79/32",    # asudbplx01d SCI NAT IP
    "172.25.50.81/32",    # asudbplx01e SCI NAT IP
    "172.25.50.85/32",    # asudbplx01b SCI NAT IP
    "10.107.43.0/24",     # bts APP/WEB Servers
    "10.106.207.6/32",    # doc-gradapp1
  ]                       # oracle-in
  #    "10.120.16.0/23",     # ENTNONPROD Private VPC
  #    "10.120.18.0/23",     # ENTNONPROD Private VPC
  #    "10.120.20.0/23",     # ENTNONPROD Private VPC
}

