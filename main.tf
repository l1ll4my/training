terraform {
  backend "atlas" {
    name = "stahll/training"
  }
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  default = "us-west-1"
}

variable "countthis" {
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.countthis}"
  ami                    = "ami-eea9f38e"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7e08481a"
  vpc_security_group_ids = ["sg-834d35e4"]

  tags {
    Identity = "autodesk-silkworm"
    Bla      = "Mine"
    Org      = "CinfraOpt"
    Name     = "web ${count.index+1}/${var.countthis}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.0.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.0.public_dns}"]
}
