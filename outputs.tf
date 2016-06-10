output "registry.dns_name" {
  value = "${aws_ecr_repository.webapp.repository_url}"
}

output "jenkins.dns_name" {
  value = "${aws_elb.jenkins.dns_name}"
}
