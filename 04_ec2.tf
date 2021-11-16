resource "aws_security_group" "ryujy_sg" {
  name = "Allow Basic"
  description = "Allow HTTP,SSH,SQL,ICMP"
  vpc_id = aws_vpc.ryu.id

  ingress = [
    {
      description = "Allow HTTP"
      from_port = var.http
      to_port = var.http
      protocol = var.pro_tcp
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ip]
      prefix_list_ids = null
      security_groups = null
      self = null
    },
    {
      description = "Allow SSH"
      from_port = var.ssh
      to_port = var.ssh
      protocol = var.pro_tcp
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ip]
      prefix_list_ids = null
      security_groups = null
      self = null
    },
    {
      description = "Allow SQL"
      from_port = var.SQL
      to_port = var.SQL
      protocol = var.pro_tcp
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ip]
      prefix_list_ids = null
      security_groups = null
      self = null
    },
    {
      description = "Allow ICMP"
      from_port = var.port_zero
      to_port = var.port_zero
      protocol = "icmp"
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ip]
      prefix_list_ids = null
      security_groups = null
      self = null
    }
  ]
  egress = [
    {
      description = "ALL"
      from_port = var.port_zero
      to_port = var.port_zero
      protocol = var.port_minus
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_ip]
      prefix_list_ids = null
      security_groups = null
      self = null
    }
  ]
  tags = {
    "Name" = "${var.name}-sg"
  }
}


/*
data "aws_ami" "amzn" {
  most_recent = 
  
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = [ "amazon" ]
}
*/

resource "aws_instance" "ryujy_weba" {
  ami = "ami-04e8dfc09b22389ad"
  instance_type = var.instance
  key_name = var.key
  availability_zone = "${var.region}${var.ava[0]}"
  private_ip = var.private_ip
  subnet_id = aws_subnet.ryujy_pub[0].id
  vpc_security_group_ids = [aws_security_group.ryujy_sg.id]
  user_data = file("./intall.sh")
}

resource "aws_eip" "ryujy_weba_ip" {
  vpc = true
  instance = aws_instance.ryujy_weba.id
  associate_with_private_ip = var.private_ip
  depends_on = [
    aws_internet_gateway.ryujy_ig
  ]
  
}

output "public_ip" {
  value = aws_instance.ryujy_weba.public_ip
}