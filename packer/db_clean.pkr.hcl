source "amazon-ebs" "db-clean" {
  region               = var.region
  source_ami           = var.ami
  instance_type        = var.instance_size
  ami_name             = "db-clean-packer"
  ssh_username         = "ubuntu"
  ssh_timeout          = "20m"
  iam_instance_profile = var.packer_profile
  tags = {
    Name    = "db_clean_ami"
    Courses = "hw-9"
    Task    = "9"
    Type    = "DB"
    BuiltBy = "Packer"
  }

}

build {
  sources = ["source.amazon-ebs.db-clean"]

  provisioner "ansible" {
    playbook_file = "../ansible/db_prepare.yml"
    extra_arguments = [
      "--extra-vars", "mysql_user=${var.db_user} mysql_pass=${var.db_pass} mysql_db=${var.db_name}"
    ]
    use_proxy = false
  }

  post-processor "manifest" {
    output     = "db-manifest.json"
    strip_path = true
    custom_data = {
      my_custom_data = "data"
    }
  }
}
