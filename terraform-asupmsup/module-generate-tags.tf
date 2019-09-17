variable "tags" {
  type = map(string)
}

module "tags" {
  source = "git::ssh://git@github.com/ASU/dco-terraform.git//modules/generate-tags?ref=0.12"

  tags = var.tags
}

