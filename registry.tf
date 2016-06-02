/* Registry ECR - only works in some Zones */ 
resource "aws_ecr_repository" "registry" {
  name = "registry"
}

resource "aws_ecr_repository_policy" "registry_policy" {
  repository = "${aws_ecr_repository.registry.name}"
  policy     = "${template_file.ecr_policy.rendered}"
}
