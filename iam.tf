/* ecs iam role and policies */
resource "aws_iam_role" "ecs_role" {
  name               = "ecs_role"
  assume_role_policy = "${file("policies/ecs-role.json")}"
}

/* ecs service scheduler role */
resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name     = "ecs_service_role_policy"
  policy   = "${file("policies/ecs-service-role-policy.json")}"
  role     = "${aws_iam_role.ecs_role.id}"
}

/* ec2 container instance role & policy */
resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name     = "ecs_instance_role_policy"
  policy   = "${file("policies/ecs-instance-role-policy.json")}"
  role     = "${aws_iam_role.ecs_role.id}"
}

resource "aws_iam_policy_attachment" "ecr-policy-attach" {
  name       = "ecr-policy-attach"
  roles      = ["${aws_iam_role.ecs_role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


/**
 * IAM profile to be used in auto-scaling launch configuration.
 */
resource "aws_iam_instance_profile" "ecs" {
  name = "ecs-instance-profile"
  path = "/"
  roles = ["${aws_iam_role.ecs_role.name}"]
}
