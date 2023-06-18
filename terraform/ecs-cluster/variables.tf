variable "workspace_name" {
  type = string
}

variable "name" {
  type        = string
  description = "An user-friendly name to identify resources"
}

variable "cloudwatch_log_group_retention_in_days" {
  type = string
  description = "Cluster log group retention days"
}

variable "tags" {
  type        = map(string)
  description = "Tags to add the resources managed by Terraform"
  default     = {}
}

variable "application_account" {
  type = object({
    vpc_id               = string
    public_subnet_cidrs  = list(string)
    private_subnet_cidrs = list(string)
    private_subnet_ids   = list(string)
  })
  description = "Workspace outputs of infra/aws/application-account infrastructure state"
}

variable "capacity_providers" {
  type = map(object({
    base_task_count              = number
    weight_after_base_task_count = number
    maximum_scaling_step_size    = optional(number)
    minimum_scaling_step_size    = optional(number)
    instance_warmup_period       = optional(number)
    target_capacity_utilization  = optional(number)
    autoscaling_group = object({
      create_security_group = optional(bool)
      security_group_ids    = optional(list(string))
      instance_type         = optional(string)
      image_id              = optional(string)
      root_volume_size_gb   = optional(number)
      min_size              = optional(number)
      max_size              = optional(number)
      desired_capacity      = optional(number)
      ssh_key_name          = optional(string)
    })
  }))
  description = "Capacity providers"
}
