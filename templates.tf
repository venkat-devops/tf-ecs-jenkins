/* template files for registry and ecs role policies */
resource "template_file" "ecs_user_data" {
  template = "${file("user_data/ecs_cluster.sh")}"

  vars {
    /* Avoid loop by using var not ${aws_ecs_cluster.default.name} */
    cluster_name      = "${var.ecs_cluster_name}"
    s3_jenkins_backup = "${var.s3_jenkins_backup}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "template_file" "ecr_policy" {
  template = "${file("policies/ecr-policy.json")}"

  vars {
    aws_account_id = "${var.aws_account_id}"
  }
}

resource "template_file" "jenkins_task" {
  template = "${file("container_definitions/jenkins_task.json")}"

  vars {
    aws_region = "${var.region}"
    log_group  = "${aws_cloudwatch_log_group.tf_logs.name}"
  }
}
