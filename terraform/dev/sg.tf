
module "sg-app" {
  source = "../modules/sg"
  vpc_id = data.terraform_remote_state.network.outputs["${var.environment}-vpc-id"]

  ingress_ports    = [22, 8000]
  ingress_protocol = "tcp"
  egress_ports     = ["-1"]
  egress_protocol  = "-1"
  cidr_ipv4        = "0.0.0.0/0"
  environment      = var.environment
}

module "sg-db-self" {
  vpc_id           = data.terraform_remote_state.network.outputs["${var.environment}-vpc-id"]
  source           = "../modules/sg"
  ingress_protocol = "-1"
  egress_protocol  = "-1"
  self             = var.self
  environment      = var.environment
}
