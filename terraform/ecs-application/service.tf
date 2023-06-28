resource "aws_service_discovery_service" "sd" {

  count = local.network_mode != "none" ? 1 : 0

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

    for_each = local.network_mode != "none" ? [1] : []

    content {

      registry_arn = aws_service_discovery_service.sd[0].arn

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
