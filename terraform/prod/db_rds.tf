
resource "aws_db_instance" "maria_rds" {
  identifier = var.rds_db_name
  allocated_storage    = 5
  max_allocated_storage = 10
  engine               =  var.rds_engine #"mariadb"
  engine_version       =  var.rds_engine_version #"10.11.6"
  instance_class       = var.rds_instance_type #"db.t3.micro"
  username             = var.rds_master_user #"root"
  password             = random_string.master_pass.result
  parameter_group_name = aws_db_parameter_group.rds_pg.name
  db_subnet_group_name = aws_db_subnet_group.rds_subg.name
  vpc_security_group_ids = module.sg-db-self.sg_self_id
  publicly_accessible = false
  skip_final_snapshot  = true
  tags = {
    Name = "Maria Prod DB"
  }
}

resource "aws_db_subnet_group" "rds_subg" {
  name       = "main"
  subnet_ids = data.terraform_remote_state.network.outputs["${var.environment}-${var.app_sub}-subnet-ids"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_parameter_group" "rds_pg" {
  name   = "${var.environment}-rds-pg"
  family = "mariadb10.11"

  parameter {
    name = "max_connections"
    value = "50"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "random_string" "master_pass" {
  length           = 12
  special          = true
  override_special = "/@%$"
}
