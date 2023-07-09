resource "aws_service_discovery_service" "sd" {

  count = local.network_mode == "awsvpc" ? 1 : 0

  name = var.name

  dns_config {
    namespace_id = var.app_account.private_dns_namespace_id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  tags = local.tags

}

locals {
  sd_container = local.network_mode != "none" && local.network_mode != "awsvpc" ? { for k, v in var.service_registries : v.container_name => v } : {}
}

resource "aws_service_discovery_service" "sd_container" {

  for_each = local.sd_container

  name = "${var.name}-${each.key}"

  dns_config {
    namespace_id = var.app_account.private_dns_namespace_id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  tags = local.tags

}

resource "aws_ecs_service" "service" {

  name                              = local.base_name
  cluster                           = var.cluster.cluster_name
  task_definition                   = aws_ecs_task_definition.main.arn
  desired_count                     = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  enable_execute_command            = true

  propagate_tags      = "TASK_DEFINITION"
  scheduling_strategy = "REPLICA"

  deployment_controller {
    type = "ECS"
  }

  dynamic "network_configuration" {

    for_each = var.enable_service ? [1] : []

    content {
      subnets          = var.service.task_subnet_ids
      security_groups  = var.create_security_group ? [module.security_group[0].security_group_id] : null
      assign_public_ip = false
    }
  }

  dynamic "service_registries" {

    for_each = local.network_mode == "none" ? [] : local.network_mode == "awsvpc" ? [{
      service_discovery_arn = aws_service_discovery_service.sd[0].arn
      }] : [for k, v in var.service_registries : merge({
        service_discovery_arn = aws_service_discovery_service.sd_container[v.container_name].arn
    }, local.sd_container[v.container_name])]

    content {

      registry_arn   = service_registries.value["service_discovery_arn"]
      container_name = lookup(service_registries.value, "container_name", null)
      container_port = lookup(service_registries.value, "container_port", 0)

    }

  }

  dynamic "load_balancer" {

    for_each = var.enable_network_lb ? [1] : []

    content {
      target_group_arn = module.nlb[0].target_group_arns[0]
      container_name   = var.service.nlb_target_container_name
      container_port   = var.service.nlb_target_container_port
    }
  }

  dynamic "capacity_provider_strategy" {

    for_each = var.capacity_providers

    content {
      capacity_provider = var.cluster.capacity_providers[capacity_provider_strategy.key].name
      weight            = capacity_provider_strategy.value["weight"]
      base              = capacity_provider_strategy.value["base"]
    }

  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = local.tags
}
