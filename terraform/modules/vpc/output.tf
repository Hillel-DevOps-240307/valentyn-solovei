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

output "public_subnets_cidrs" {
  value = aws_subnet.public_subnets[*].cidr_block
}

output "private_subnets_cidrs" {
  value = aws_subnet.private_subnets[*].cidr_block
}
