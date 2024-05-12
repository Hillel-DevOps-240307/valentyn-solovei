
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

resource "aws_instance" "this" {
  count = var.inst_count
  ami                    = var.ami_id
  instance_type          = var.inst_type
  vpc_security_group_ids = local.sg_ids
  key_name               = var.key_name
  subnet_id = element(local.sub_id,count.index)

  tags = {
    Name    = "${var.environment}-${var.inst_name}${count.index + 1}"

  }
}
