variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = null
}

variable "public_subnets" {
  description = "Subnet CIDR blocks"
  type        = list(string)
  default     = null
}

variable "private_subnets" {
  description = "Subnet CIDR blocks"
  type        = list(string)
  default     = null
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = null

}

locals {
  create_public_subnets  = length(var.public_subnets) > 0
  create_private_subnets = length(var.private_subnets) > 0
}
