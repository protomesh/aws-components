<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_capacity_providers"></a> [capacity\_providers](#module\_capacity\_providers) | ../ecs-capacity-provider | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | terraform-aws-modules/ecs/aws | ~> 5.2.0 |
| <a name="module_task_execution_iam_policy"></a> [task\_execution\_iam\_policy](#module\_task\_execution\_iam\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 5.0 |
| <a name="module_task_execution_role"></a> [task\_execution\_role](#module\_task\_execution\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 5.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_account"></a> [app\_account](#input\_app\_account) | Workspace outputs of protomesh/aws-components/terraform/app-account infrastructure state | <pre>object({<br>    vpc_id               = string<br>    public_subnet_cidrs  = list(string)<br>    private_subnet_cidrs = list(string)<br>    private_subnet_ids   = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | Capacity providers | <pre>map(object({<br>    base_task_count              = number<br>    weight_after_base_task_count = number<br>    maximum_scaling_step_size    = optional(number)<br>    minimum_scaling_step_size    = optional(number)<br>    instance_warmup_period       = optional(number)<br>    target_capacity_utilization  = optional(number)<br>    autoscaling_group = object({<br>      create_security_group = optional(bool)<br>      security_group_ids    = optional(list(string))<br>      instance_type         = optional(string)<br>      image_id              = optional(string)<br>      root_volume_size_gb   = optional(number)<br>      min_size              = optional(number)<br>      max_size              = optional(number)<br>      desired_capacity      = optional(number)<br>      ssh_key_name          = optional(string)<br>    })<br>    egress_with_cidr_blocks = optional(list(object({<br>      from_port   = number<br>      to_port     = number<br>      protocol    = string<br>      description = optional(string)<br>      cidr_blocks = list(string)<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Cluster log group retention days | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | An user-friendly name to identify resources | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add the resources managed by Terraform | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_capacity_providers"></a> [capacity\_providers](#output\_capacity\_providers) | Capacity providers |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name |
| <a name="output_task_execution_role"></a> [task\_execution\_role](#output\_task\_execution\_role) | Task execution role ARN (must have ECR repository read access) |
<!-- END_TF_DOCS -->