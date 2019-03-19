module "vpc" {
  source = "git::ssh://git@github.com/ASU/dco-terraform.git//modules/get-vpc"

  vpc_name = "${var.vpc_name}"
}
