locals {
  base_name = "${var.workspace_name}-${var.name}"

  tags = merge({
    Environment  = var.workspace_name
    SourceModule = "protomesh/aws/terraform/ecs-capacity-provider"
  }, var.tags)
}
