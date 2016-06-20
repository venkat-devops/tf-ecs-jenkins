/* depends on RDS */

resource "aws_ecs_task_definition" "web" {
  family                = "web"
  container_definitions = "${template_file.web_task.rendered}"
}

/* db bootstrap task */
resource "aws_ecs_task_definition" "web_db_bootstap" {
  family                = "web_db_bootstrap"
  container_definitions = "${template_file.web_db_bootstrap.rendered}"
}

/* ELB for web service */
resource "aws_elb" "webapp" {
  name = "webapp-terraform-elb"
  availability_zones = ["us-east-1b", "us-east-1c", "us-east-1d"]

/*
  access_logs {
    bucket = "foo"
    bucket_prefix = "bar"
    interval = 60
  }
*/

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 10
    target = "HTTP:80/en/"
    interval = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "webapp-terraform-elb"
    ManagedBy = "Terraform"
  }
}


/* web server service */
resource "aws_ecs_service" "web_server" {
  name = "web_server"
  cluster = "${aws_ecs_cluster.default.id}"
  task_definition = "${aws_ecs_task_definition.web.arn}"
  desired_count = 0  /* start with 0, then turn up after DB migration */
  iam_role = "${aws_iam_role.ecs_role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs-service-policy-attach"]

  load_balancer {
    elb_name = "${aws_elb.webapp.name}"
    container_name = "${var.web_server_container_name}"
    container_port = 80
  }
}

