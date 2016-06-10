/* allow only traffic from the ecs cluster */
resource "aws_security_group" "allow_ecs" {
  name        = "allow_ecs"
  description = "Allow only traffic from the ecs Cluster"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ecs.id}"]
  }

  tags {
    Name      = "allow_ecs"
    ManagedBy = "Terraform"
  }
}

resource "aws_db_instance" "webapp_db" {
  allocated_storage      = "${var.webapp_db_size}"
  apply_immediately      = true
  engine                 = "${var.webapp_db_engine}"
  engine_version         = "${var.webapp_db_engine_version}"
  instance_class         = "${var.webapp_db_instance_class}"
  multi_az               = false
  name                   = "${var.webapp_db_user}"
  password               = "${var.webapp_db_password}"
  publicly_accessible    = false
  storage_type           = "gp2"                             /* General Purpose SSD */
  username               = "${var.webapp_db_user}"
  vpc_security_group_ids = ["${aws_security_group.ecs.id}"]

  tags {
    Name      = "${var.webapp_name}-db"
    ManagedBy = "Terraform"
  }
}
