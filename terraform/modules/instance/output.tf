output "public_ip" {
  value = aws_instance.this[*].public_ip
}

output "private_ip" {
  value = aws_instance.this[*].private_ip
}

output "public_dns" {
  value = aws_instance.this[*].public_dns
}

output "instance_names" {
  value = aws_instance.this[*].tags["Name"]

}

#value = [ for id in aws_security_group.this-self[*].id : id ]
