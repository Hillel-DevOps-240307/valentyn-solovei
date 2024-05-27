data "aws_ami" "web_ami" {
  filter {
    name   = "name"
    values = ["web-app*"]
  }
  owners = ["self"]
}

data "aws_ami" "db_ami" {
  filter {
    name   = "name"
    values = ["db-packer"]
  }
  owners = ["self"]
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "courses-tf-state-bucket"
    dynamodb_table = "terraform-state-lock-dynamo"
    key            = "network/terraform.tfstate"
    region         = "eu-central-1"
  }
}
