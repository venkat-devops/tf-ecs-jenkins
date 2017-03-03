resource "aws_ecs_task_definition" "jenkins" {
  family                = "jenkins"
  container_definitions = "${data.template_file.jenkins_task.rendered}"

  volume {
    name      = "jenkins_home"
    host_path = "/var/jenkins_home"
  }

  volume {
    name      = "docker_sock"
    host_path = "/var/run/docker.sock"
  }
}

/* s3 bucket for initial plugins */
resource "aws_s3_bucket" "jenkins-plugins" {
  bucket = "jenkins-plugins.${var.s3_bucket_base_key}"
  acl    = "private"

  tags {
    Name      = "Jenkins plugins"
    ManagedBy = "Terraform"
  }

  provisioner "local-exec" {
    /* Download the required plugins and push to s3*/
    command = "./scripts/batch-install-jenkins-plugins.sh -p jenkins-plugins.txt -d jenkins-plugins && aws s3 cp --recursive jenkins-plugins s3://jenkins-plugins.${var.s3_bucket_base_key}"
  }
}

/* ELB for web service */
resource "aws_elb" "jenkins" {
  name               = "${var.stack_prefix}-jenkins-terraform-elb"
  availability_zones = ["${var.availability_zones}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    target              = "HTTP:8080/login"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name      = "${var.stack_prefix}-jenkins-terraform-elb"
    ManagedBy = "Terraform"
  }
}

/* jenkins server service */
resource "aws_ecs_service" "jenkins_server" {
  name            = "${var.stack_prefix}_jenkins_server"
  cluster         = "${aws_ecs_cluster.default.id}"
  task_definition = "${aws_ecs_task_definition.jenkins.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_role.arn}"
  depends_on      = ["aws_iam_policy_attachment.ecs-service-policy-attach"]

  /* Allow the only instance to die during relaunch */
  deployment_minimum_healthy_percent = 0

  load_balancer {
    elb_name       = "${aws_elb.jenkins.name}"
    container_name = "jenkins-master"
    container_port = 8080
  }
}

/* Nice name */
resource "aws_route53_record" "jenkins" {
  zone_id = "${var.dns_zone_id}"
  name    = "${var.stack_prefix}-jenkins.${var.dns_root}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elb.jenkins.dns_name}"]
}
