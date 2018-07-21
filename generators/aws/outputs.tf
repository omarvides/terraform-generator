output "instance_id" {
  value = "${aws_instance.{{.Values.instance_name | default "sample-instance"}}.id}"
}

output "public_ip" {
  value = "${aws_instance.{{.Values.instance_name | default "sample-instance"}}.public_ip}"
}

output "ami_id" {
  value = "${aws_instance.{{.Values.instance_name | default "sample-instance"}}.ami}"
}

output "instance_type" {
  value = "${aws_instance.{{.Values.instance_name | default "sample-instance"}}.instance_type}"
}

output "vpc_security_group_ids" {
  value = "${aws_instance.{{.Values.instance_name | default "sample-instance"}}.vpc_security_group_ids}"
}