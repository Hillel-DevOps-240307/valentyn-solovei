output "sg_id" {
  value = [for id in aws_security_group.this[*].id : id]
}

output "sg_self_id" {
  value = [ for id in aws_security_group.this-self[*].id : id ]
}
