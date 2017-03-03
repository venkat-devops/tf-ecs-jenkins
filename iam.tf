/* ecs iam role and policies */
resource "aws_iam_role" "ecs_role" {
  name               = "${var.stack_prefix}-ecs_role"
  assume_role_policy = "${file("policies/ecs-role.json")}"
}

/* ecs service scheduler role (register/deregister ELBs, view ec2)*/
resource "aws_iam_policy_attachment" "ecs-service-policy-attach" {
  name       = "${var.stack_prefix}-ecs-service-policy"
  roles      = ["${aws_iam_role.ecs_role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

/* ecs container instance role (ecs commands & AWS logging service)*/
resource "aws_iam_policy_attachment" "ecs-ec2-policy-attach" {
  name       = "${var.stack_prefix}-ecs-ec2-policy"
  roles      = ["${aws_iam_role.ecs_role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

/* ecr access (read and upload to ECR repository)*/
resource "aws_iam_policy_attachment" "ecr-policy-attach" {
  name       = "${var.stack_prefix}-ecr-policy"
  roles      = ["${aws_iam_role.ecs_role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

/* s3 readonly - load jenkins save */
resource "aws_iam_policy_attachment" "s3-policy-attach" {
  name       = "${var.stack_prefix}-s3-policy"
  roles      = ["${aws_iam_role.ecs_role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

/**
 * IAM profile to be used in auto-scaling launch configuration.
 */
resource "aws_iam_instance_profile" "ecs" {
  name  = "${var.stack_prefix}-ecs-instance-profile"
  path  = "/"
  roles = ["${aws_iam_role.ecs_role.name}"]
}
