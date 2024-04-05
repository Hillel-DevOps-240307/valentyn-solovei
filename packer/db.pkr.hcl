source "amazon-ebs" "db-app" {
  region        = var.region
  source_ami    = var.ami
  instance_type = var.instance_size
  ami_name      = "db-packer"
  ssh_username  = "ubuntu"
  ssh_timeout   = "20m"
  tags = {
    Name    = "db_ami"
    Courses = "hw-4"
    Task    = "4"
    Type    = "DB"
    BuiltBy = "Packer"

  }

}

build {
  sources = ["source.amazon-ebs.db-app"]

  provisioner "shell" {
    script          = "scripts/db.sh"
    execute_command = "sudo {{ .Path }}"
  }

  provisioner "file" {
    source      = "scripts/init.sql"
    destination = "/tmp/init.sql"
  }

  provisioner "shell" {
    inline          = ["mysql < /tmp/init.sql"]
    execute_command = "sudo {{ .Path }}"
  }

  provisioner "file" {
    source      = "scripts/db_backup.sh"
    destination = "/tmp/db_backup.sh"
  }

  provisioner "shell" {
    inline          = ["mv /tmp/db_backup.sh /opt/db_backup.sh"]
    execute_command = "sudo {{ .Path }}"
  }

  provisioner "shell" {
    inline = ["chmod +x /opt/db_backup.sh"]
  }

  provisioner "file" {
    source      = "cron.d/db_backups"
    destination = "/tmp/db_backups"
  }

  provisioner "shell" {
    inline          = ["mv /tmp/db_backups /etc/cron.d/db_backups"]
    execute_command = "sudo {{ .Path }}"
  }
  provisioner "shell" {
    inline          = ["chown root:root /etc/cron.d/db_backups"]
    execute_command = "sudo {{ .Path }}"
  }


  post-processor "manifest" {
    output     = "db-manifest.json"
    strip_path = true
    custom_data = {
      my_custom_data = "data"
    }
  }
}
