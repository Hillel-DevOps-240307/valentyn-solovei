resource "aws_subnet" "public_subnets" {
  count             = local.create_public_subnets ? length(var.public_subnets) : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = data.aws_availability_zones.current.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-public-subnets"
  }
}

resource "aws_internet_gateway" "this" {
  count  = local.create_public_subnets ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-igw"
  }
}


resource "aws_route_table" "public" {
  count  = local.create_public_subnets ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

resource "aws_route" "public" {
  count                  = local.create_public_subnets ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_route_table_association" "public" {

  count          = local.create_public_subnets ? length(var.public_subnets) : 0
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}
