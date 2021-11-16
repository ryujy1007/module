resource "aws_eip" "ryujy_eip_ng" {
  vpc = true
}

resource "aws_nat_gateway" "ryujy_ng" {
  allocation_id = aws_eip.ryujy_eip_ng.id
  subnet_id = aws_subnet.ryujy_pub[0].id
  tags = {
    "Name" = "${var.name}-ng"
  }
  depends_on = [
    aws_internet_gateway.ryujy_ig
  ]
}

resource "aws_route_table" "ryujy_ngrt" {
  vpc_id = aws_vpc.ryu.id

  route {
    cidr_block = var.cidr_route
    gateway_id = aws_nat_gateway.ryujy_ng.id
  }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}

resource "aws_route_table_association" "ryujy_ngass" {
  count = length(var.cidr_private)
  subnet_id = aws_subnet.ryujy_pri[count.index].id
  route_table_id = aws_route_table.ryujy_ngrt.id  
}
