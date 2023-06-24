output "vpc_id" {
  description = "ID of VPC created to host application workloads"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "database_subnet_ids" {
  description = "IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "database_subnet_group_name" {
  description = "Group name of database subnets"
  value       = module.vpc.database_subnet_group_name
}

output "public_subnet_cidrs" {
  description = "CIDRs of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnet_cidrs" {
  description = "CIDRs of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "database_subnet_cidrs" {
  description = "CIDRs of database subnets"
  value       = module.vpc.database_subnets_cidr_blocks
}

output "private_dns_namespace_id" {
  value       = aws_service_discovery_private_dns_namespace.private_dns.id
  description = "Private service discovery DNS namespace ID"
}

output "private_dns_zone" {
  value       = aws_service_discovery_private_dns_namespace.private_dns.name
  description = "Service discovery private DNS name"
}

output "public_dns_zone" {
  value       = var.public_dns_zone
  description = "Service discovery public DNS name"
}

output "public_dns_certificate_arn" {
  value       = module.acm_public_dns.acm_certificate_arn
  description = "Public service discovery domain certificate for use with tls encryption things like ELBs"
}

output "public_dns_certificate_arn_us_east_1" {
  value       = module.acm_public_dns_us_east_1.acm_certificate_arn
  description = "Public service discovery domain certificate for use with tls encryption things like ELBs (specific from region us-east-1)"
}
