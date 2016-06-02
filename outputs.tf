output "registry.dns_name" {
  value = "${aws_ecr_repository.registry.repository_url}"
}
