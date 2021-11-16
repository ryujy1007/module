provider "aws" {
  region = var.region
}

resource "aws_key_pair" "ryujy_key" {
  key_name = var.key
  #    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqlL89UaTZEmHTJ/05aSlB1WdiJ8ACMFZvlSVxsEJkS/TYVI/CADTUdKkiIuK2020W/YCPvzU9eKNr0KklQvH0GIWc48RIx0m6/V+RVddizYQeCr7oVJDPZn+emvjYUfZT09G83hxrYIyVrZ+H3tS22MUjWF4SR1bKBYb2Ky3vANa3N0bguVHxWHmy0v4keagR3Qc6cGqtD9r+pbHGmimO35sBuyHBdA3sr8CTchKBLTSATsx6AXrhzb0X3VWNMQd3ebvxCHWgoowivHp0SXiYr2gYJXxrKI7Lfm6skBe+oUGGZeC1dSE61ksHoTcsKbTeu60UNgm/JAdhV1ggNyH3bdncjNdgHNgpb2CD1HvsIzaTRk54TjxINKoktOaxidpSbf/Hdzz6Ck2nIzzuO/fUYJ0R0on+cnrYOVWhceaPySYRMrw57cl+zY1Rw/UsAWc4yA/XBeLyblXnZ/xNKjxR0bQzrninyPdUxOS8CU88FGpOIRcVxMTgK1qfQcutjHc="
  public_key = file("../../.ssh/ryujy-key.pub")
}

resource "aws_vpc" "ryu" {
  cidr_block = var.cidr_main
  tags = {
    "Name" = "${var.name}-vpc"
  }
}

# 가용영역의 public subnet
resource "aws_subnet" "ryujy_pub" {
  count             = length(var.cidr_public) #2
  vpc_id            = aws_vpc.ryu.id
  cidr_block        = var.cidr_public[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.ava[count.index]}"
  }
}

# 가용영역의 private subnet
resource "aws_subnet" "ryujy_pri" {
  count = length(var.cidr_private)
  vpc_id            = aws_vpc.ryu.id
  cidr_block        = var.cidr_private[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.ava[count.index]}"
  }
}


# 가용영역의 private DB subnet
resource "aws_subnet" "ryujy_pridb" {
  count = length(var.cidr_privatedb)
  vpc_id            = aws_vpc.ryu.id
  cidr_block        = var.cidr_privatedb[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb${var.ava[count.index]}"
  }
}