data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  base_name = "${var.workspace_name}-${var.name}"

  tags = merge({
    Environment  = var.workspace_name
    SourceModule = "protomesh/aws/terraform/ecs-application"
  }, var.tags)
}
