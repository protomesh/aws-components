module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.name
  cidr = var.vpc_cidr

  azs              = var.availability_zones
  public_subnets   = var.subnets.public_cidrs
  private_subnets  = var.subnets.private_cidrs
  database_subnets = var.subnets.database_cidrs

  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

locals {
  vpc_endpoints_subnets = concat(
    module.vpc.private_subnets,
    module.vpc.public_subnets,
    module.vpc.database_subnets,
  )
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    s3 = {
      service = "s3"
      tags    = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      service      = "dynamodb"
      service_type = "Gateway"
      route_table_ids = flatten([
        module.vpc.intra_route_table_ids,
        module.vpc.private_route_table_ids,
        module.vpc.public_route_table_ids,
      ])
      policy = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags   = var.tags
    },
    logs = {
      service             = "logs"
      private_dns_enabled = true
      security_group_ids  = [aws_security_group.vpc_tls.id]
      subnet_ids          = local.vpc_endpoints_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      tags                = var.tags
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      security_group_ids  = [aws_security_group.vpc_tls.id]
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      security_group_ids  = [aws_security_group.vpc_tls.id]
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
    },
    ecs = {
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
    },
    ecs_telemetry = {
      create              = false
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = local.vpc_endpoints_subnets
      tags                = var.tags
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    # codedeploy = {
    #   service             = "codedeploy"
    #   private_dns_enabled = true
    #   subnet_ids          = module.vpc.private_subnets
    # },
    # codedeploy_commands_secure = {
    #   service             = "codedeploy-commands-secure"
    #   private_dns_enabled = true
    #   subnet_ids          = module.vpc.private_subnets
    # },
  }

  tags = var.tags
}

################################################################################
# Supporting Resources
################################################################################

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["dynamodb:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:sourceVpce"

      values = [module.vpc.vpc_id]
    }
  }
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}

resource "aws_security_group" "vpc_tls" {
  name_prefix = "${var.name}-vpc-tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = var.tags
}
