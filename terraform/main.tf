resource "aws_instance" "web-srv" {
  ami                    = data.aws_ami.web_ami.id
  instance_type          = var.inst_type
  vpc_security_group_ids = [aws_security_group.sg_app.id, aws_security_group.sg_db.id]
  key_name               = "aws"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.key_path)
    host        = self.public_ip
  }

  tags = {
    Name    = "web_app_tf"
    Task    = "6"
    Courses = "hw-6"
  }
}
