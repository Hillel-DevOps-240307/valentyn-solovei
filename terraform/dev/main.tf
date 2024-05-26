
locals {
  web_sg = concat(module.sg-db-self.sg_self_id, module.sg-app.sg_id)

  app_names = module.web-srv.instance_names
  app_ips   = module.web-srv.public_ip
  db_names  = module.db-srv.instance_names
  db_ips    = module.db-srv.private_ip
}

module "web-srv" {
  inst_count           = 1
  source               = "../modules/instance"
  inst_type            = var.inst_type
  inst_name            = var.app_name
  key_name             = var.key_name
  security_group_ids   = local.web_sg
  ami_id               = data.aws_ami.base_ami.id
  environment          = var.environment
  subnet_ids           = data.terraform_remote_state.network.outputs["${var.environment}-${var.app_sub}-subnet-ids"]
  iam_instance_profile = var.iam_instance_profile
}

module "db-srv" {
  source             = "../modules/instance"
  inst_type          = var.inst_type
  inst_name          = var.db_name
  key_name           = var.key_name
  security_group_ids = module.sg-db-self.sg_self_id
  ami_id             = data.aws_ami.db_ami.id
  environment        = var.environment
  subnet_ids         = data.terraform_remote_state.network.outputs["${var.environment}-${var.db_sub}-subnet-ids"]
}

resource "aws_ssm_parameter" "db_host_ip" {
  name        = "MYSQL_HOST"
  description = "The parameter description"
  type        = "String"
  value       = module.db-srv.private_ip[0]
  overwrite   = true
}

resource "local_file" "generate_ansible_inventory" {
  content = templatefile("./files/template.tpl", {
    app_names = local.app_names
    app_ips   = local.app_ips
    db_names  = local.db_names
    db_ips    = local.db_ips
    user      = var.provision_user
  })
  filename = "../../ansible/${var.environment}_hosts"
}
