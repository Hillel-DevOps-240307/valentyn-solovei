module "vpc-dev-env" {
  source   = "../modules/vpc"
  vpc_cidr = "172.16.0.0/16"
  public_subnets = [
    "172.16.0.0/24",
    "172.16.1.0/24"
  ]
  private_subnets = [
    "172.16.30.0/24",
    "172.16.31.0/24"
  ]
  environment = "dev"
}


module "vpc-prod-env" {
  source   = "../modules/vpc"
  vpc_cidr = "10.31.0.0/16"
  public_subnets = [
    "10.31.0.0/24",
    "10.31.1.0/24",
    "10.31.2.0/24"
  ]
  private_subnets = [
    "10.31.100.0/24",
    "10.31.101.0/24"
  ]
  environment = "prod"
}
