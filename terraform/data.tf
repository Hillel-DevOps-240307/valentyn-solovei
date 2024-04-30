data "aws_ami" "web_ami" {
  filter {
    name   = "name"
    values = ["web-app*"]
  }
  owners = ["730335557158"]
}

data "aws_ami" "db_ami" {
  filter {
    name   = "name"
    values = ["db*"]
  }
  owners = ["730335557158"]
}
