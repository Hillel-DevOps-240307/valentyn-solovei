variable "region" {
  description = "Region"
  type        = string
  default     = "eu-central-1"
}

variable "inst_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "def_vpc" {
  description = "default vpc"
  type        = string
  default     = "vpc-0b36aecd7aedb13e5"
}

variable "key_path" {
  description = "path to private key file"
  type        = string
  default     = "~/.ssh/aws.pem"
}
