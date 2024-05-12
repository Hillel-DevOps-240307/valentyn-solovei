output "vpc_id" {
  value = aws_vpc.this.id
}
output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "public_subnets_id" {
  value = [for sub in aws_subnet.public_subnets[*] : sub.id]
}

output "private_subnets_id" {
  value = [for sub in aws_subnet.private_subnets[*] : sub.id]
}
