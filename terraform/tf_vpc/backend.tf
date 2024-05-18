terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "courses-tf-state-bucket"
    dynamodb_table = "terraform-state-lock-dynamo"
    key            = "network/terraform.tfstate"
    region         = "eu-central-1"
  }
}
