source "amazon-ebs" "web-app" {
  region        = var.region
  source_ami    = var.ami
  instance_type = var.instance_size
  ami_name      = "web-app-packer"
  ssh_username  = "ubuntu"
  ssh_timeout   = "20m"
  tags = {
    Name    = "web_ami"
    Courses = "hw-4"
    Task    = "4"
    Type    = "WEB"
    BuiltBy = "Packer"

  }

}

build {
  sources = ["source.amazon-ebs.web-app"]

  provisioner "shell" {
    script          = "scripts/web_pkgs.sh"
    execute_command = "sudo {{ .Path }}"
  }

  provisioner "file" {
    source = "flask-app"
    destination = "/tmp"
  }

  provisioner "shell" {
    inline = ["mv /tmp/flask-app /etc"]
    execute_command = "sudo {{ .Path }}"
  }

provisioner "shell" {
  inline = ["touch /etc/flask-app/flask-app.env && chmod 666 /etc/flask-app/flask-app.env"]
  execute_command = "sudo {{ .Path }}"
}


  provisioner "file" {
    source      = "systemd/flask-app.service"
    destination = "/tmp/flask-app.service"
  }

  provisioner "shell" {
    inline          = ["mv /tmp/flask-app.service /etc/systemd/system/."]
    execute_command = "sudo {{ .Path }}"
  }

  provisioner "shell" {
    inline          = ["systemctl enable flask-app "]
    execute_command = "sudo {{ .Path }}"
  }

  provisioner "shell" {
    script = "scripts/web-app.sh"
  }


  post-processor "manifest" {
    output     = "web-app-manifest.json"
    strip_path = true
    custom_data = {
      my_custom_data = "data"
    }
  }
}
