/* Registry ECR - only works in some Zones */
resource "aws_ecr_repository" "webapps" {
  count = "${length(split(",", var.webapp_names))}"
  name  = "${trimspace(element(split(",", var.webapp_names), count.index))}"
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  count      = "${length(split(",", var.webapp_names))}"
  repository = "${element(aws_ecr_repository.webapps.*.name, count.index)}"
  policy     = "${template_file.ecr_policy.rendered}"
}
