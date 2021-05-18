provider "aws" {
  region=var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = name
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "terraform-test-instance-ape22" {
  ami             = "${data.aws_ami.ubuntu.id}"
  count = 2
  instance_type   = "t2.nano"

  tags = {
    Name = "test-instance-ape"
    timestamp = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}
