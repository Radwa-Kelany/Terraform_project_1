resource "aws_vpc" "custom_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "custom_vpc"
  }
}

resource "aws_internet_gateway" "custom_gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "custom_gw"
  }
} 

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  for_each = tomap(var.public_cidrs)
  cidr_block = each.value
  
  tags = {
    Name = "subnet_${each.key}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  for_each = tomap(var.private_cidrs)
  cidr_block = each.value
  
  tags = {
    Name = "subnet_${each.key}"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_gw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "public_association" {
  for_each = tomap(aws_subnet.public_subnet)
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_association" {
  for_each = tomap(aws_subnet.private_subnet)
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}




# -----------------------------------
output "private_subnets_id" {
  value = aws_subnet.private_subnet
}
output "public_subnets_id" {
  value = aws_subnet.public_subnet
}