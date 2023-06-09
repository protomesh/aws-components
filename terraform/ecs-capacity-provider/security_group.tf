
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  count = var.create_security_group ? 1 : 0

  use_name_prefix = true
  name            = local.base_name

  vpc_id = var.app_account.vpc_id

  ingress_with_cidr_blocks = [for k, v in var.ingress_with_cidr_blocks : merge(v, {
    cidr_blocks = join(",", v.cidr_blocks)
  })]

  egress_with_cidr_blocks = concat([
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "TLS endpoints anywhere"
      cidr_blocks = "0.0.0.0/0"
    },
  ], [for k, v in var.egress_with_cidr_blocks : merge(v, {
    cidr_blocks = join(",", v.cidr_blocks)
  })])

  tags = local.tags
}
