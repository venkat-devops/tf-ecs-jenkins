/* Registry ECR - only works in some Zones */
resource "aws_ecr_repository" "webapps" {
  /* real lists are coming in 0.7 */
  count = "${length(split(",", var.webapp_names))}"
  name  = "${trimspace(element(split(",", var.webapp_names), count.index))}"
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  count      = "${length(split(",", var.webapp_names))}"
  repository = "${element(aws_ecr_repository.webapps.*.name, count.index)}"
  policy     = "${data.template_file.ecr_policy.rendered}"
}
