output "dev-vpc-id" {
  value = module.vpc-dev-env.vpc_id
}


output "dev-public-subnet-ids" {
  value = [for sub in module.vpc-dev-env.public_subnets_id[*] : sub]
}

output "dev-private-subnet-ids" {
  value = [for sub in module.vpc-dev-env.private_subnets_id[*] : sub]
}

output "prod-vpc-id" {
  value = module.vpc-prod-env.vpc_id
}

output "prod-public-subnet-ids" {
  value = [for sub in module.vpc-prod-env.public_subnets_id[*] : sub]
}

output "prod-private-subnet-ids" {
  value = [for sub in module.vpc-prod-env.private_subnets_id[*] : sub]
}
