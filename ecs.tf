/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  image_id = "${lookup(var.amis, var.region)}"

  /* @todo - split out to a variable */
  instance_type        = "${var.instance_type}"
  key_name             = "${var.ssh_key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  security_groups      = ["${aws_security_group.ecs.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

  /* Nearly time to make this even better */
  user_data = "${data.template_file.ecs_user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Autoscaling group.
 */
resource "aws_autoscaling_group" "ecs" {
  name                 = "${var.stack_prefix}-ecs-asg"
  availability_zones   = ["${var.availability_zones}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"

  /* @todo - variablize */
  min_size         = 1
  max_size         = 10
  desired_capacity = 1

  tag {
    key                 = "ManagedBy"
    value               = "Terraform"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.ecs_cluster_name}_asg"
    propagate_at_launch = true
  }
}

/* ecs service cluster */
resource "aws_ecs_cluster" "default" {
  name = "${var.stack_prefix}-${var.ecs_cluster_name}"
}
