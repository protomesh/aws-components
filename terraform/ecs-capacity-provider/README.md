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
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | ~> 6.5 |
| <a name="module_asg_policy"></a> [asg\_policy](#module\_asg\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 5.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_placement_group.placement_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/placement_group) | resource |
| [aws_ssm_parameter.recommended_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_account"></a> [app\_account](#input\_app\_account) | Workspace outputs of protomesh/aws-components/terraform/app-account infrastructure state | <pre>object({<br>    vpc_id = string<br>    public_subnet_cidrs = list(string)<br>    private_subnet_cidrs = list(string)<br>    private_subnet_ids = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | ication-ecs module | `string` | n/a | yes |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Create security group according to cluster application | `bool` | `true` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Only used to set initial node count, ignored on changes | `number` | `1` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The AMI from which to launch the instance (leave empty to use Amazon recommended image) | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type of the capacity provider | `string` | `"t3.micro"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum cluster instance count | `number` | `2` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimun cluster instance count | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | An user-friendly name to identify resources | `string` | n/a | yes |
| <a name="input_root_volume_size_gb"></a> [root\_volume\_size\_gb](#input\_root\_volume\_size\_gb) | Rool volume (/dev/xvda) size in GBs | `number` | `30` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Additional security IDs to attach to cluster | `list(string)` | `[]` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | SSH key name to use in the launch template | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add the resources managed by this Terraform module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | Managed Autoscaling Group ARN to be used as a capacity provider for ECS cluster |
| <a name="output_name"></a> [name](#output\_name) | Capacity provider name |
<!-- END_TF_DOCS -->