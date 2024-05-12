variable "inst_type" {
    description = "instance type"
  type = string
  default = null
}

variable "inst_name" {
  description = "instance name"
  type = string
  default = null
}

variable "key_name" {
  description = "key name"
  type = string
  default = null
}

variable "inst_count" {
  description = "instance count"
  type = number
  default = 1
}

variable "ami_id" {
    description = "ami id to use"
    type = string
    default = ""
}

variable "environment" {
    description = "Environment"
    type = string
    default = null
}
variable "subnet_type" {
  description = "public/private subnet"
  type = string
  default = null
}

variable "security_group_ids" {
    description = "security groups id"
    type = list(string)
    default = null
}

locals {
  sub_id = data.terraform_remote_state.network.outputs["${var.environment}-${var.subnet_type}-subnet-ids"]
  sg_ids=var.security_group_ids
}
