resource "aws_cloudwatch_log_group" "tf_logs" {
  /* TODO maybe dynamic to match the app name */
  name = "tf_logs"
  retention_in_days = 1
}
