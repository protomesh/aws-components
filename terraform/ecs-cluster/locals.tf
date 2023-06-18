locals {
  base_name = var.name

  tags = merge({
    SourceModule = "protomesh/aws/terraform/ecs-cluster"
  }, var.tags)
}
