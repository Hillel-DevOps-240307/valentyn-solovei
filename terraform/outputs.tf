
output "web_srv_public_ip" {
  value = aws_instance.web-srv.public_ip
}

output "web_srv_private_ip" {
  value = aws_instance.web-srv.private_ip
}

output "web_srv_public_dns" {
  value = aws_instance.web-srv.public_dns
}

output "db_srv_private_ip" {
  value = aws_instance.db-srv.public_ip
}

output "db_srv_public_ip" {
  value = aws_instance.db-srv.private_ip
}
