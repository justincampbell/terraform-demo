variable "aws_region" { default = "us-east-1" }
variable "aws_az_1" { default = "us-east-1c" }
variable "aws_az_2" { default = "us-east-1d" }
variable "aws_instance_type" { default = "m3.medium" }
variable "aws_key_name" { default = "justincampbell" }

variable "app_name" { default = "helloworld" }
variable "domain_name" { default = "justincampbell.me" }
variable "subdomain" { default = "terraform-demo" }

provider "aws" {
  region = "${var.aws_region}"
}
