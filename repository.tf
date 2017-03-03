/* Registry ECR - only works in some Zones - Don't need to prefix these names, since they are inside the ECR with a prefixed name */
resource "aws_ecr_repository" "webapps" {
  count = "${length(var.webapp_names)}"
  name  = "${var.webapp_names[count.index]}"
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  count      = "${length(var.webapp_names)}"
  repository = "${aws_ecr_repository.webapps.*.name[count.index]}"
  policy     = "${data.template_file.ecr_policy.rendered}"
}
