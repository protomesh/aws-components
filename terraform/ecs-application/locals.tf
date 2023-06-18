data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  base_name = var.name

  tags = merge({
    SourceModule = "protomesh/aws/terraform/ecs-application"
  }, var.tags)
}
