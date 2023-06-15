output "task_execution_role" {
  value       = module.task_execution_role.iam_role_arn
  description = "Task execution role ARN (must have ECR repository read access)"
}

output "cluster_name" {
  value       = local.base_name
  description = "Cluster name"
}

output "capacity_providers" {
  value       = module.capacity_providers
  description = "Capacity providers"
}