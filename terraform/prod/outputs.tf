output "app_sg_id" {
  value = module.sg-app.sg_id
}
output "db_sg_id" {
  value = module.sg-db-self.sg_self_id
}

output "web_srv_public_ip" {
  value = module.web-srv.public_ip
}

output "web_srv_private_ip" {
  value = module.web-srv.private_ip
}

output "web_srv_public_dns" {
  value = module.web-srv.public_dns
}

# output "db_srv_private_ip" {
#   value = module.db-srv.private_ip
# }

# output "db_srv_public_ip" {
#   value = module.db-srv.public_ip
# }

output "rds_db_dns_name" {
  value = aws_db_instance.maria_rds.address

}

output "rds_db_master" {
  value = random_string.master_pass.result

}
