source "amazon-ebs" "web-app" {
  region               = var.region
  source_ami           = var.ami
  instance_type        = var.instance_size
  ami_name             = "web-app-packer"
  ssh_username         = "ubuntu"
  ssh_timeout          = "20m"
  iam_instance_profile = var.packer_profile
  tags = {
    Name    = "web_ami"
    Courses = "hw-9"
    Task    = "9"
    Type    = "WEB"
    BuiltBy = "Packer"
  }

}


build {
  sources = ["source.amazon-ebs.web-app"]

  provisioner "ansible" {
    playbook_file = "../ansible/app_install.yml"
    ansible_env_vars = ["ANSIBLE_ROLES_PATH=../ansible/roles"]
    use_proxy     = false
  }

  post-processor "manifest" {
    output     = "web-app-manifest.json"
    strip_path = true
    custom_data = {
      my_custom_data = "data"
    }
  }
}
