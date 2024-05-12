
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














# resource "aws_security_group" "sg_app" {
#   name        = "allow_web"
#   description = "Allow traffic for web application"
#     vpc_id = data.terraform_remote_state.network.outputs["${var.environment}-vpc-id"]
#   tags = {
#     Name    = "sg_app-7"
#     Task    = "7"
#     Courses = "hw-7"
#   }

# }

# resource "aws_security_group" "sg_db" {
#   name        = "allow_db"
#   description = "Allow traffic for db application"
#   vpc_id = data.terraform_remote_state.network.outputs["${var.environment}-vpc-id"]
#   tags = {
#     Name    = "sg_db-7"
#     Task    = "7"
#     Courses = "hw-7"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
#   security_group_id = aws_security_group.sg_app.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "tcp"
#   to_port           = 22
#   from_port         = 22
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_http" {
#   security_group_id = aws_security_group.sg_app.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "tcp"
#   to_port           = 8000
#   from_port         = 8000
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all" {
#   security_group_id = aws_security_group.sg_app.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = -1
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_all_ingress_web" {
#   security_group_id            = aws_security_group.sg_app.id
#   referenced_security_group_id = aws_security_group.sg_app.id
#   ip_protocol                  = -1
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_egress_web" {
#   security_group_id            = aws_security_group.sg_app.id
#   referenced_security_group_id = aws_security_group.sg_app.id
#   ip_protocol                  = -1
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_all_ingress_db" {
#   security_group_id            = aws_security_group.sg_db.id
#   referenced_security_group_id = aws_security_group.sg_db.id
#   ip_protocol                  = -1
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_egress_db" {
#   security_group_id            = aws_security_group.sg_db.id
#   referenced_security_group_id = aws_security_group.sg_db.id
#   ip_protocol                  = -1
# }
