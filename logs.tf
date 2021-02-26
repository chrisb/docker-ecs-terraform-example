resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/${var.project_name}-app"
  retention_in_days = 30

  tags = {
    Name = "${var.project_name}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "${var.project_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
}