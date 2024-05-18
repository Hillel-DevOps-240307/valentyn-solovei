data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "courses-tf-state-bucket"
    dynamodb_table = "terraform-state-lock-dynamo"
    key            = "network/terraform.tfstate"
    region         = "eu-central-1"
  }
}


resource "aws_security_group" "this" {
  count = var.self ? 0 : 1
  name   = "${var.environment}-sg"
  vpc_id = data.terraform_remote_state.network.outputs["${var.environment}-vpc-id"]

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port =  var.ingress_protocol != "-1" ? port.value : 0
      to_port =  var.ingress_protocol != "-1" ? port.value : 0
      protocol = var.ingress_protocol
      cidr_blocks = [var.cidr_ipv4]
    }

  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_ports
    content {
      from_port = var.egress_protocol != "-1" ? port.value : 0
      to_port = var.egress_protocol != "-1" ? port.value : 0
      protocol = var.egress_protocol
      cidr_blocks = [var.cidr_ipv4]
    }

  }

  tags = {
    Name = "${var.environment}-sg"
  }
}


resource "aws_security_group" "this-self" {
  count = var.self ? 1 : 0
  name   = "${var.environment}-sg-self"
  vpc_id = data.terraform_remote_state.network.outputs["${var.environment}-vpc-id"]


  dynamic "ingress" {

    iterator = port
    for_each = local.allow_all_ingress_traffic == 0 ? ["1"] : var.ingress_ports
    content {
      from_port =  var.ingress_protocol != "-1" ? port.value : 0
      to_port =  var.ingress_protocol != "-1" ? port.value : 0
      protocol = var.ingress_protocol
      self = var.self
    }

  }

  dynamic "egress" {
    iterator = port
    for_each = local.allow_all_egress_traffic == 0 ? ["1"] : var.egress_ports
    content {
      from_port =  var.egress_protocol != "-1" ? port.value : 0
      to_port = var.egress_protocol != "-1" ? port.value : 0
      protocol = var.egress_protocol
      self = tobool( var.self)
    }

  }

  tags = {
    Name = "${var.environment}-sg-self"
  }
}
