
locals {
  web_sg = concat(module.sg-db-self.sg_self_id, module.sg-app.sg_id)

  app_names = module.web-srv.instance_names
  app_ips   = module.web-srv.public_ip
  # db_names  = module.db-srv.instance_names
  # db_ips    = module.db-srv.private_ip
  db_names  = aws_db_instance.maria_rds.address
}

module "web-srv" {
  inst_count         = 3
  source             = "../modules/instance"
  inst_type          = var.inst_type
  inst_name          = var.app_name
  key_name           = var.key_name
  security_group_ids = local.web_sg
  ami_id             = data.aws_ami.web_ami.id
  environment        = var.environment
  subnet_ids         = data.terraform_remote_state.network.outputs["${var.environment}-${var.app_sub}-subnet-ids"]
  iam_instance_profile = var.iam_instance_profile
}

# module "db-srv" {
#   inst_count         = 1
#   source             = "../modules/instance"
#   inst_type          = var.inst_type
#   inst_name          = var.db_name
#   key_name           = var.key_name
#   security_group_ids = module.sg-db-self.sg_self_id
#   ami_id             = data.aws_ami.db_ami.id
#   environment        = var.environment
#   subnet_ids         = data.terraform_remote_state.network.outputs["${var.environment}-${var.app_sub}-subnet-ids"]
# }


resource "aws_ssm_parameter" "db_host_ip" {
  name        = "MYSQL_HOST_${var.environment}"
  description = "The parameter description"
  type        = "String"
  value       = aws_db_instance.maria_rds.address
}

resource "aws_ssm_parameter" "db_password_ip" {
  name        = "MYSQL_PASSWORD_${var.environment}"
  description = "The parameter description"
  type        = "SecureString"
  value       = random_string.master_pass.result
}

resource "aws_ssm_parameter" "db_user" {
  name        = "MYSQL_USER_${var.environment}"
  description = "The parameter description"
  type        = "String"
  value       = var.rds_master_user
}

resource "local_file" "generate_ansible_inventory" {
  content = templatefile("./files/template.tpl", {
    app_names = local.app_names
    app_ips   = local.app_ips
    db_names  = local.db_names
    user      = var.provision_user
  })
  filename = "../../ansible/${var.environment}_hosts"
}
