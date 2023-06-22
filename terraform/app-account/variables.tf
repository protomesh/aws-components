variable "env_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "name" {
  type = string
}

variable "allowed_github_oidc_subjects" {
  type = list(string)
}

variable "availability_zones" {
    type = list(string)
}

variable "subnets" {
  type = object({
    public_cidrs   = list(string)
    private_cidrs  = list(string)
    database_cidrs = list(string)
  })
}

variable "public_dns_zone" {
    type = string
}

variable "private_dns_zone" {
    type = string
}
