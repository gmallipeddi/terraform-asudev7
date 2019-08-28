variable "region" {}

variable "profile" {
  default = "default"
}

variable "admin_role_arn" {}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"

  assume_role {
    role_arn = "${var.admin_role_arn}"
  }
}

terraform {
  backend "s3" {}
}

variable "dms_enabled" {
  default = 0
}

variable "dms_instance_class" {}

variable "vpc_name" {}
