variable "name" {
  type        = string
  description = "An user-friendly name to identify resources"
}

variable "cluster_name" {
  type        = string
  description = " ication-ecs module"
}

variable "create_security_group" {
  type        = bool
  description = "Create security group according to cluster application"
  default     = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "Additional security IDs to attach to cluster"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to add the resources managed by this Terraform module"
  default     = {}
}

variable "instance_type" {
  type        = string
  description = "Instance type of the capacity provider"
  default     = "t3.micro"
}

variable "image_id" {
  type        = string
  description = "The AMI from which to launch the instance (leave empty to use Amazon recommended image)"
  default     = null
}

variable "root_volume_size_gb" {
  type        = number
  description = "Rool volume (/dev/xvda) size in GBs"
  default     = 30
}

variable "min_size" {
  type        = number
  description = "Minimun cluster instance count"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum cluster instance count"
  default     = 2
}

variable "desired_capacity" {
  type        = number
  description = "Only used to set initial node count, ignored on changes"
  default     = 1
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key name to use in the launch template"
  default     = null
}

variable "app_account" {
  type = object({
    vpc_id = string
    public_subnet_cidrs = list(string)
    private_subnet_cidrs = list(string)
    private_subnet_ids = list(string)
  })
  description = "Workspace outputs of protomesh/aws-components/terraform/app-account infrastructure state"
}

variable "ingress_with_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = optional(string)
    cidr_blocks = list(string)
  }))
  description = "Ingress rules to add to the security group"
  default     = []
}

variable "egress_with_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = optional(string)
    cidr_blocks = list(string)
  }))
  description = "Egress rules to add to the security group"
  default     = []
}