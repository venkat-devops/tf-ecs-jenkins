resource "aws_cloudwatch_log_group" "webapp_logs" {
  /* DONE - maybe dynamic to match the app name */

  /* TODO - will the web apps acutally use that? */
  count = "${length(var.webapp_names)}"
  name  = "${var.stack_prefix}_${var.webapp_names[count.index]}_logs"

  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "jenkins_logs" {
  /* TODO maybe dynamic to match the app name */
  name = "${var.stack_prefix}_jenkins_logs"

  retention_in_days = 1
}
