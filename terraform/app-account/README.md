<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account_kms"></a> [account\_kms](#module\_account\_kms) | terraform-aws-modules/kms/aws | ~> 1.0 |
| <a name="module_acm_public_dns"></a> [acm\_public\_dns](#module\_acm\_public\_dns) | terraform-aws-modules/acm/aws | >= 4.3.2 |
| <a name="module_acm_public_dns_us_east_1"></a> [acm\_public\_dns\_us\_east\_1](#module\_acm\_public\_dns\_us\_east\_1) | terraform-aws-modules/acm/aws | >= 4.3.2 |
| <a name="module_iam_github_oidc_policy"></a> [iam\_github\_oidc\_policy](#module\_iam\_github\_oidc\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 5.0 |
| <a name="module_iam_github_oidc_provider"></a> [iam\_github\_oidc\_provider](#module\_iam\_github\_oidc\_provider) | terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider | ~> 5.0 |
| <a name="module_iam_github_oidc_role"></a> [iam\_github\_oidc\_role](#module\_iam\_github\_oidc\_role) | terraform-aws-modules/iam/aws//modules/iam-github-oidc-role | ~> 5.0 |
| <a name="module_records"></a> [records](#module\_records) | terraform-aws-modules/route53/aws//modules/records | >= 2.10.2 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_account_setting_default.vpc_trunking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_account_setting_default) | resource |
| [aws_security_group.vpc_tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_service_discovery_private_dns_namespace.private_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_private_dns_namespace) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.dynamodb_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.generic_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.public_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_github_oidc_subjects"></a> [allowed\_github\_oidc\_subjects](#input\_allowed\_github\_oidc\_subjects) | List of GitHub OIDC subjects allowed to access the application: org/repository:ref | `list(string)` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones to configure network resources and high-availability | `list(string)` | n/a | yes |
| <a name="input_enable_dummy_record_a"></a> [enable\_dummy\_record\_a](#input\_enable\_dummy\_record\_a) | Create a dummy record A at the root of public zone domain for cognito validation | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | An user-friendly name to identify resources | `string` | n/a | yes |
| <a name="input_private_dns_zone"></a> [private\_dns\_zone](#input\_private\_dns\_zone) | Private DNS zone domain name | `string` | n/a | yes |
| <a name="input_public_dns_zone"></a> [public\_dns\_zone](#input\_public\_dns\_zone) | Public DNS zone domain name | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets CIDRs | <pre>object({<br>    public_cidrs   = list(string)<br>    private_cidrs  = list(string)<br>    database_cidrs = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The VPC CIDR, must contain all subnets CIDRs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet_cidrs"></a> [database\_subnet\_cidrs](#output\_database\_subnet\_cidrs) | CIDRs of database subnets |
| <a name="output_database_subnet_group_name"></a> [database\_subnet\_group\_name](#output\_database\_subnet\_group\_name) | Group name of database subnets |
| <a name="output_database_subnet_ids"></a> [database\_subnet\_ids](#output\_database\_subnet\_ids) | IDs of database subnets |
| <a name="output_iam_github_oidc_role_arn"></a> [iam\_github\_oidc\_role\_arn](#output\_iam\_github\_oidc\_role\_arn) | ARN of the GitHub role to be assumed |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | Workspace KMS key arn |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | Workspace KMS key id |
| <a name="output_private_dns_namespace_id"></a> [private\_dns\_namespace\_id](#output\_private\_dns\_namespace\_id) | Private service discovery DNS namespace ID |
| <a name="output_private_dns_zone"></a> [private\_dns\_zone](#output\_private\_dns\_zone) | Service discovery private DNS name |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | CIDRs of private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of private subnets |
| <a name="output_public_dns_certificate_arn"></a> [public\_dns\_certificate\_arn](#output\_public\_dns\_certificate\_arn) | Public service discovery domain certificate for use with tls encryption things like ELBs |
| <a name="output_public_dns_certificate_arn_us_east_1"></a> [public\_dns\_certificate\_arn\_us\_east\_1](#output\_public\_dns\_certificate\_arn\_us\_east\_1) | Public service discovery domain certificate for use with tls encryption things like ELBs (specific from region us-east-1) |
| <a name="output_public_dns_zone"></a> [public\_dns\_zone](#output\_public\_dns\_zone) | Service discovery public DNS name |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | CIDRs of public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of VPC created to host application workloads |
<!-- END_TF_DOCS -->