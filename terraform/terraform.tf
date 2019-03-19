variable "region" {}

variable "profile" {
  default = "default"
}

variable "admin_role_arn" {}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
  version = "~> 1.53"

  assume_role {
    role_arn = "${var.admin_role_arn}"
  }
}

terraform {
  backend "s3" {}
}
