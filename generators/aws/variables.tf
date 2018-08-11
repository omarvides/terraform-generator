variable "region" {
  type = "string"
  default = "{{.Values.region | default "us-east-1"}}"
}

variable "instance_type" {
  type = "string"
  default = "{{.Values.instance_type | default "t2.micro"}}"
}

variable "ami" {
  type = "string"
  default = "{{.Values.ami_id | default ""}}"
}

variable "name" {
  type = "string"
  default = "{{.Values.instance_name | default "sample-instance"}}"
}