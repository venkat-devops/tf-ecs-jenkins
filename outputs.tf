output "jenkins.dns_name" {
  value = "${aws_elb.jenkins.dns_name}"
}

output "dns_zone_id" {
  value = "${var.dns_zone_id}"
}

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.default.id}"
}

output "ecs_iam_role_arn" {
  value = "${aws_iam_role.ecs_role.arn}"
}

output "ecs_security_group_id" {
  value = "${aws_security_group.ecs.id}"
}

output "jenkins_secret" {
  value = "${aws_iam_access_key.jenkins.secret}"
}

output "jenkins_id" {
  value = "${aws_iam_access_key.jenkins.id}"
}
