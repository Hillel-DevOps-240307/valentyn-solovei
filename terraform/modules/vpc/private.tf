resource "aws_subnet" "private_subnets" {
  count  = local.create_private_subnets ? length(var.private_subnets) : 0
  vpc_id = aws_vpc.this.id

  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.current.names[count.index]

  tags = {
    Name = "${var.environment}-private-subnets"
    cidr = "${var.private_subnets[count.index]}"
  }
}

resource "aws_route_table" "private" {
  count  = local.create_private_subnets ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = local.create_private_subnets ? length(var.private_subnets) : 0
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}


resource "aws_vpc_endpoint" "s3_endp" {
  count             = local.create_private_subnets ? 1 : 0
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-central-1.s3"
  route_table_ids   = [aws_route_table.private[0].id]
  vpc_endpoint_type = "Gateway"

  policy = <<POLICY
  {
	"Version": "2008-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": "*",
			"Action": "*",
			"Resource": "*"
		}
	]
  }
  POLICY

  tags = {
    Name = "${var.environment}-vpce-s3"
  }
}
