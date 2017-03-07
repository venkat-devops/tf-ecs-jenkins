/* template files for registry and ecs role policies */
data "template_file" "ecs_user_data" {
  template = "${file("user_data/ecs_cluster.sh")}"

  vars {
    /* Avoid loop by using var not ${aws_ecs_cluster.default.name} */
    cluster_name     = "${var.stack_prefix}-${var.ecs_cluster_name}"
    s3_plugin_bucket = "${aws_s3_bucket.jenkins-plugins.bucket}"

    /* Set to "" to avoid pulling in a backup */
    s3_backup_path = "${var.s3_jenkins_backup}"
  }
}

data "template_file" "ecr_policy" {
  template = "${file("policies/ecr-policy.json")}"

  vars {
    aws_account_id = "${var.aws_account_id}"
  }
}

data "template_file" "jenkins_task" {
  template = "${file("container_definitions/jenkins_task.json")}"

  vars {
    aws_region = "${var.region}"
    log_group  = "${aws_cloudwatch_log_group.jenkins_logs.name}"
  }
}

data "template_file" "jenkins_task_role_policy" {
  template = "${file("policies/jenkins_task_role_policy.json")}"

  vars {
    jenkins_backup_path   = "${var.s3_jenkins_backup}"
    jenkins_backup_bucket = "${element(split("/", var.s3_jenkins_backup), 0)}"
  }
}
