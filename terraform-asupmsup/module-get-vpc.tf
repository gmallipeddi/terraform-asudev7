module "vpc" {
  source = "git::ssh://git@github.com/ASU/dco-terraform.git//modules/get-vpc?ref=0.12"

  vpc_name = var.vpc_name
}

