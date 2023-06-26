resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs-apps/${var.cluster.cluster_name}/${local.base_name}"
  retention_in_days = var.log_retention_in_days
  tags              = local.tags
}
