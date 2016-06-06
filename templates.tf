/* template files for registry and ecs role policies */
resource "template_file" "ecr_policy" {
  template = "${file("policies/ecr-policy.json")}"

  vars {
    aws_account_id = "${var.aws_account_id}"
  }
}

resource "template_file" "web_task" {
  template = "${file("container_definitions/web_task.json")}"

  vars {
    /* These must include the quotes when set */
    entrypoint     = "null"
    command        = "null"

    aws_region     = "${var.region}"
    container_name = "${var.web_server_container_name}"
    cpu            = 200
    db_host        = "${aws_db_instance.webapp_db.address}"
    db_name        = "${aws_db_instance.webapp_db.name}"
    db_password    = "${var.webapp_db_password}"
    db_port        = "${aws_db_instance.webapp_db.port}"
    log_group      = "${aws_cloudwatch_log_group.tf_logs.name}"
    memory         = 300
    webapp_image   = "${var.webapp_image}"
    webapp_name    = "${var.webapp_name}"
    webapp_tag     = "${var.webapp_tag}"
  }
}

resource "template_file" "web_db_bootstrap" {
  template = "${file("container_definitions/web_no_port_task.json")}"

  vars {
    /* A shell command, passed to sh -c */
    command        = "/home/docker/code/app/manage.py migrate && /home/docker/code/app/manage.py loaddata users.json cms.data.json qfr.json locations.json"

    aws_region     = "${var.region}"
    container_name = "web_task"
    cpu            = 200
    db_host        = "${aws_db_instance.webapp_db.address}"
    db_name        = "${aws_db_instance.webapp_db.name}"
    db_password    = "${var.webapp_db_password}"
    db_port        = "${aws_db_instance.webapp_db.port}"
    log_group      = "${aws_cloudwatch_log_group.tf_logs.name}"
    memory         = 300
    webapp_image   = "${var.webapp_image}"
    webapp_name    = "${var.webapp_name}"
    webapp_tag     = "${var.webapp_tag}"
  }
}
