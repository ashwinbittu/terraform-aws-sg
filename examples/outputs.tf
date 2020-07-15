output "aws_security_group_instances_id" {
  value = "${aws_security_group.myinstance.*.id}"
}

output "aws_security_group_elb_id" {
  value = "${aws_security_group.elb-securitygroup.*.id}"
}