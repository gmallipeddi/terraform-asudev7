variable "tags" {
  type = "map"
}

module "tags" {
  source = "git::ssh://git@github.com/ASU/dco-terraform.git//modules/generate-tags"

  tags = "${var.tags}"
}
