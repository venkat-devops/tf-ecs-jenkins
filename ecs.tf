/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  image_id             = "${lookup(var.amis, var.region)}"
  /* @todo - split out to a variable */
  instance_type        = "${var.instance_type}"
  key_name             = "${var.ssh_key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  security_groups      = ["${aws_security_group.ecs.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.default.name} > /etc/ecs/ecs.config"

  lifecycle { create_before_destroy = true }
}

/**
 * Autoscaling group.
 */
resource "aws_autoscaling_group" "ecs" {
  name                 = "ecs-asg"
  availability_zones   = ["${split(",", var.availability_zones)}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  /* @todo - variablize */
  min_size             = 1
  max_size             = 10
  desired_capacity     = 1

  tag {
    key = "ManagedBy"
    value = "Terraform"
    propagate_at_launch = true
  }
}

/* ecs service cluster */
resource "aws_ecs_cluster" "default" {
  name = "${var.ecs_cluster_name}"
}
