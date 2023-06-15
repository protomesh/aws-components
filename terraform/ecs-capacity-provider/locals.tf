locals {
  base_name = "${var.workspace.env_name}-${var.name}"

  tags = merge({
    Environment  = var.workspace.env_name
    SourceModule = "protomesh/terraform/ecs-cluster/capacity-provider"
  }, var.tags)
}
