/* template files for registry and ecs role policies */
resource "template_file" "ecr_policy" {
  template = "${file("policies/ecr-policy.json")}"

  vars {
    aws_account_id = "${var.aws_account_id}"
  }
}
