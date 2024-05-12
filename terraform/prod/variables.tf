variable "region" {
  description = "Region"
  type        = string
  default     = "eu-central-1"
}

variable "inst_type" {
  description = "Instance type"
  type        = string
  default     = null
}

variable "key_name" {
  description = "path to private key file"
  type        = string
  default     = null
}

variable "environment" {
  description = "environment"
  type        = string
  default     = null
}

variable "db_sub" {
  description = "database subnet"
  type        = string
  default     = null

}
variable "app_sub" {
  description = "application subnet"
  type        = string
  default     = null
}

variable "db_name" {
  description = "database name"
  type        = string
  default     = null
}

variable "app_name" {
  description = "application name"
  type        = string
  default     = null
}

variable "self" {
  description = "for self security group"
  type        = bool
  default     = false
}

variable "provision_user" {
  description = "user for ansible"
  type        = string
  default     = null
}
