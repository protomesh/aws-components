module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  count = var.create_security_group ? 1 : 0

  use_name_prefix = true
  name            = "${local.base_name}-ecs-task"

  vpc_id = var.app_account.vpc_id

  ingress_with_cidr_blocks = [ for v in var.ingress_with_cidr_blocks : merge(v, {
    cidr_blocks = join(",", compact(v.cidr_blocks))
  })]
  egress_with_cidr_blocks  = [ for v in var.egress_with_cidr_blocks : merge(v, {
    cidr_blocks = join(",", compact(v.cidr_blocks))
  })]

  tags = local.tags
}
