provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "{{.Values.instance_name | default "sample-instance"}}" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  tags {
    Name = "${var.name}"
  }
}