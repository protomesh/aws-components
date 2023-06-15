module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.2.0"

  cluster_name = local.base_name

  create_cloudwatch_log_group            = true
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_tags              = local.tags

  cluster_settings = {
    name  = "containerInsights"
    value = "enabled"
  }

  autoscaling_capacity_providers = {
    for name, capacity_provider in var.capacity_providers :
    name => {
      auto_scaling_group_arn         = capacity_provider.autoscaling_group_arn
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size   = try(capacity_provider.maximum_scaling_step_size, 3)
        minimum_scaling_step_size   = try(capacity_provider.minimum_scaling_step_size, 1)
        status                      = "ENABLED"
        target_capacity_utilization = try(capacity_provider.target_capacity_utilization, 70)
        instance_warmup_period      = try(capacity_provider.instance_warmup_period, 150)
      }

      default_capacity_provider_strategy = {
        weight = capacity_provider.weight_after_base_task_count
        base   = capacity_provider.base_task_count
      }
    }
  }

  tags = local.tags
}


