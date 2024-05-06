
resource "aws_instance" "db-srv" {
  ami                    = data.aws_ami.db_ami.id
  instance_type          = var.inst_type
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  key_name               = "aws"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.key_path)
    host        = self.private_ip
  }
  tags = {
    Name    = "db_tf"
    Task    = "6"
    Courses = "hw-6"
  }
}

resource "aws_security_group" "sg_app" {
  name        = "allow_web"
  description = "Allow traffic for web application"

  tags = {
    Name    = "sg_app"
    Task    = "6"
    Courses = "hw-6"
  }

}

resource "aws_security_group" "sg_db" {
  name        = "allow_db"
  description = "Allow traffic for db application"
  # vpc_id      = var.def_vpc
  tags = {
    Name    = "sg_db"
    Task    = "6"
    Courses = "hw-6"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg_app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 22
  from_port         = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg_app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 8000
  from_port         = 8000
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.sg_app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ingress_web" {
  security_group_id            = aws_security_group.sg_app.id
  referenced_security_group_id = aws_security_group.sg_app.id
  ip_protocol                  = -1
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress_web" {
  security_group_id            = aws_security_group.sg_app.id
  referenced_security_group_id = aws_security_group.sg_app.id
  ip_protocol                  = -1
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ingress_db" {
  security_group_id            = aws_security_group.sg_db.id
  referenced_security_group_id = aws_security_group.sg_db.id
  ip_protocol                  = -1
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress_db" {
  security_group_id            = aws_security_group.sg_db.id
  referenced_security_group_id = aws_security_group.sg_db.id
  ip_protocol                  = -1
}
