module "vpc" {
  source = "git::ssh://git@github.com/ASU/dco-terraform.git//modules/get-vpc?ref=0.11"

  vpc_name = "${var.vpc_name}"
}
