
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  count = var.create_security_group ? 1 : 0

  use_name_prefix = true
  name            = local.base_name

  vpc_id = var.application_account.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Jumbpox from public"
      cidr_blocks = join(",", var.application_account.public_subnet_cidrs)
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "TLS endpoints anywhere"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = local.tags
}
