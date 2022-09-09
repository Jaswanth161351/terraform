resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "greeshma-vpc-${terraform.workspace}"
    Location    = "Banglore"
    Department  = "IT"
    Environment = terraform.workspace
    AwsAccId = data.aws_caller_identity.current.account_id
  }
}

# create 2 public subnets

resource "aws_subnet" "public" {
  for_each          = var.pub_sunets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags = {
    "Name" = "public1"
  }
  depends_on = [
    aws_internet_gateway.ig
  ]
}

# create 2 private subnets

resource "aws_subnet" "private" {
  for_each          = var.pri_sunets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags = {
    "Name" = "private"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id
}

# Create route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

# Attach route table to the public subnets
resource "aws_route_table_association" "a" {
  count          = length(local.pub_sub_ids)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.public.id
}
