variable "name" {
  type        = string
  description = "An user-friendly name to identify resources"
}

variable "tags" {
  description = "Tags to add the resources managed by Terraform"
  type        = map(string)
  default     = {}
}

variable "capacity_providers" {
  type = map(object({
    weight = number
    base   = number
  }))
  description = "Capacity provider to place tasks (the key must be the name of the capacity provider)"
}

variable "create_security_group" {
  type        = bool
  description = "Create security group according to cluster application"
  default     = true
}

variable "desired_count" {
  type        = number
  description = "Desired count for tasks"
  default     = 2
}

variable "log_retention_in_days" {
  type        = number
  description = "Days for log retention in CW, must be one of [0 1 3 5 7 14 30 60 90 120 150 180 365 400 545 731 1827 2192 2557 2922 3288 3653]"
  default     = 7
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "Seconds to wait before check the health of a new task"
  default     = 60
}

variable "cluster" {
  type = object({
    cluster_name        = string
    task_execution_role = string
    capacity_providers = map(object({
      autoscaling_group_arn = string
      name                  = string
    }))
  })
  description = "ecs-cluster outputs of application account infrastructure state"
}

variable "task_iam_policy" {
  type        = any
  description = "Task IAM policy, allowing application to do operations on AWS services"
}

variable "container_definitions" {
  type        = any
  description = "AWS ECS container definitions for this application (you can use this module: https://github.com/terraform-aws-modules/terraform-aws-ecs/blob/master/modules/container-definition)."
}

variable "enable_network_lb" {
  type        = bool
  description = "Enables network load balancer to expose the service (service must be enabled)"
  default     = false
}

variable "service" {
  type = object({
    nlb_target_container_name = optional(string)
    nlb_target_container_port = optional(number)
    nlb_subnet_ids            = optional(list(string))
    task_subnet_ids           = list(string)
  })
  description = "Service configuration"
  default = {
    nlb_target_container_name = "default"
    nlb_target_container_port = 443
    nlb_subnet_ids            = []
    task_subnet_ids           = []
  }
}

variable "enable_service" {
  type        = bool
  description = "value to enable or disable the creation of ECS service"
  default     = true
}

variable "ingress_with_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = optional(string)
    cidr_blocks = list(string)
  }))
  description = "Ingress rules to add to the security group"
  default     = []
}

variable "egress_with_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = optional(string)
    cidr_blocks = list(string)
  }))
  description = "Egress rules to add to the security group"
  default     = []
}

variable "app_account" {
  type = object({
    private_dns_namespace_id   = string
    private_dns_zone           = string
    public_dns_certificate_arn = string
    vpc_id                     = string
  })
  description = "Workspace outputs of protomesh/aws-components/terraform/app-account infrastructure state"
}
