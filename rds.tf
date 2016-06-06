resource "aws_db_instance" "webapp_db" {
  allocated_storage   = "${var.webapp_db_size}"
  engine              = "${var.webapp_db_engine}"
  engine_version      = "${var.webapp_db_engine_version}"
  instance_class      = "${var.webapp_db_instance_class}"
  storage_type        = "gp2"                             /* General Purpose SSD */
  name                = "${var.webapp_db_user}"
  username            = "${var.webapp_db_user}"
  password            = "${var.webapp_db_password}"
  publicly_accessible = false
  apply_immediately   = true

  /* TODO
    db_subnet_group_name = (by default created in default VPC
    multi_az   = default false
    parameter_group_name = "default.mysql5.6"
  */

  tags {
    Name      = "${var.webapp_name}-db"
    ManagedBy = "Terraform"
  }
}
