resource "aws_service_discovery_private_dns_namespace" "private_dns" {
  name = var.private_dns_zone
  vpc  = module.vpc.vpc_id
  tags = var.tags
}

data "aws_route53_zone" "public_dns" {
  name         = "${var.public_dns_zone}."
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = ">= 2.10.2"

  zone_name = var.public_dns_zone

  records = var.enable_dummy_record_a ? [
    {
      name = ""
      type = "A"
      ttl  = 60
      records = [
        "8.8.8.8",
      ]
    },
  ] : []

}

module "acm_public_dns" {
  source  = "terraform-aws-modules/acm/aws"
  version = ">= 5.1.1"

  domain_name  = var.public_dns_zone
  zone_id      = data.aws_route53_zone.public_dns.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.public_dns_zone}"
  ]

  wait_for_validation = true

  tags = var.tags
}


module "acm_public_dns_us_east_1" {
  source  = "terraform-aws-modules/acm/aws"
  version = ">= 5.1.1"

  providers = {
    aws = aws.us_east_1
  }

  domain_name  = var.public_dns_zone
  zone_id      = data.aws_route53_zone.public_dns.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.public_dns_zone}"
  ]

  wait_for_validation = true

  tags = var.tags
}
