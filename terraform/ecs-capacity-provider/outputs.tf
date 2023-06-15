output "autoscaling_group_arn" {
  value       = module.asg.autoscaling_group_arn
  description = "Managed Autoscaling Group ARN to be used as a capacity provider for ECS cluster"
}

output "name" {
  value       = local.base_name
  description = "Capacity provider name"
}
