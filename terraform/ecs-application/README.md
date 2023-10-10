<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nlb"></a> [nlb](#module\_nlb) | terraform-aws-modules/alb/aws | ~> 8.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_task_iam_policy"></a> [task\_iam\_policy](#module\_task\_iam\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 5.0 |
| <a name="module_task_role"></a> [task\_role](#module\_task\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_service_discovery_service.sd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [aws_service_discovery_service.sd_container](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_account"></a> [app\_account](#input\_app\_account) | Workspace outputs of protomesh/aws-components/terraform/app-account infrastructure state | <pre>object({<br>    private_dns_namespace_id   = string<br>    private_dns_zone           = string<br>    public_dns_certificate_arn = string<br>    vpc_id                     = string<br>  })</pre> | n/a | yes |
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | Capacity provider to place tasks (the key must be the name of the capacity provider) | <pre>map(object({<br>    weight = number<br>    base   = number<br>  }))</pre> | n/a | yes |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | ecs-cluster outputs of application account infrastructure state | <pre>object({<br>    cluster_name        = string<br>    task_execution_role = string<br>    capacity_providers = map(object({<br>      autoscaling_group_arn = string<br>      name                  = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | AWS ECS container definitions for this application (you can use this module: https://github.com/terraform-aws-modules/terraform-aws-ecs/blob/master/modules/container-definition). | `any` | n/a | yes |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Create security group according to cluster application | `bool` | `true` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Desired count for tasks | `number` | `2` | no |
| <a name="input_egress_with_cidr_blocks"></a> [egress\_with\_cidr\_blocks](#input\_egress\_with\_cidr\_blocks) | Egress rules to add to the security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    description = optional(string)<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_enable_network_lb"></a> [enable\_network\_lb](#input\_enable\_network\_lb) | Enables network load balancer to expose the service (service must be enabled) | `bool` | `false` | no |
| <a name="input_enable_service"></a> [enable\_service](#input\_enable\_service) | value to enable or disable the creation of ECS service | `bool` | `true` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | Seconds to wait before check the health of a new task | `number` | `60` | no |
| <a name="input_ingress_with_cidr_blocks"></a> [ingress\_with\_cidr\_blocks](#input\_ingress\_with\_cidr\_blocks) | Ingress rules to add to the security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    description = optional(string)<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Days for log retention in CW, must be one of [0 1 3 5 7 14 30 60 90 120 150 180 365 400 545 731 1827 2192 2557 2922 3288 3653] | `number` | `7` | no |
| <a name="input_name"></a> [name](#input\_name) | An user-friendly name to identify resources | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service configuration | <pre>object({<br>    nlb_target_container_name = optional(string)<br>    nlb_target_container_port = optional(number)<br>    nlb_subnet_ids            = optional(list(string))<br>    task_subnet_ids           = optional(list(string))<br>    health_check_path         = optional(string)<br>    health_check_port         = optional(number)<br>    network_mode              = optional(string)<br>  })</pre> | <pre>{<br>  "nlb_subnet_ids": [],<br>  "nlb_target_container_name": "default",<br>  "nlb_target_container_port": 443,<br>  "task_subnet_ids": []<br>}</pre> | no |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | Service registries to add to the service | <pre>list(object({<br>    container_port = number<br>    container_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add the resources managed by Terraform | `map(string)` | `{}` | no |
| <a name="input_task_iam_policy"></a> [task\_iam\_policy](#input\_task\_iam\_policy) | Task IAM policy, allowing application to do operations on AWS services | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_private_domain"></a> [application\_private\_domain](#output\_application\_private\_domain) | Domain for this service |
| <a name="output_nlb_dns_name"></a> [nlb\_dns\_name](#output\_nlb\_dns\_name) | NLB for DNS name |
| <a name="output_service_private_domains"></a> [service\_private\_domains](#output\_service\_private\_domains) | Domain for this service |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | Task role arn |
<!-- END_TF_DOCS -->