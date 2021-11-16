#10.0.0.0/16 vpc 전용 internet gateway
resource "aws_internet_gateway" "ryujy_ig" {
  vpc_id = aws_vpc.ryu.id
  tags = {
    "Name" = "${var.name}-ig"
  }
}

resource "aws_route_table" "ryujy_rt" {
  vpc_id = aws_vpc.ryu.id

  route {
    cidr_block = var.cidr_route
    gateway_id = aws_internet_gateway.ryujy_ig.id
  }
  tags = {
    "Name" = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "ryujy_rtass" {
  count = length(var.cidr_public)
  subnet_id = aws_subnet.ryujy_pub[count.index].id
  route_table_id = aws_route_table.ryujy_rt.id
}