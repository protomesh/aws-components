variable "name" {
  type        = string
  description = "An user-friendly name to identify resources"
}

variable "allowed_github_oidc_subjects" {
  type        = list(string)
  description = "List of GitHub OIDC subjects allowed to access the application: org/repository:ref"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to configure network resources and high-availability"
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC CIDR, must contain all subnets CIDRs"
}

variable "subnets" {
  type = object({
    public_cidrs   = list(string)
    private_cidrs  = list(string)
    database_cidrs = list(string)
  })
  description = "Subnets CIDRs"
}

variable "public_dns_zone" {
  type        = string
  description = "Public DNS zone domain name"
}

variable "private_dns_zone" {
  type        = string
  description = "Private DNS zone domain name"
}

variable "enable_dummy_record_a" {
  type        = bool
  description = "Create a dummy record A at the root of public zone domain for cognito validation"
  default     = true
}


variable "tags" {
    type        = map(string)
    description = "Tags to be applied to resources"
}