## ========================
## Creating AWS VPC section
## ========================
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.tag
  }
}

## ==================================
## Creating AWS internet gateway section
## ==================================
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tag}-gw"
  }
}
## ==================================
## Creating AWS route table section
## ==================================
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name =  "${var.tag}-rt"
  }
}
## ==========================================
## Creating AWS route table associate section
## ==========================================
resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.r.id
}
## ================================
## Creating AWS Nat Gateway section
## ================================


resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.natip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "gw NAT"
  }
}
## ==========================================
## Creating AWS private route table section
## ==========================================

resource "aws_route_table" "pr" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.private_subnet_cidr
    gateway_id = aws_nat_gateway.ngw.id
  }



  tags = {
    Name =  "${var.tag}-prt"
  }
}
## ==========================================
## Creating AWS private route table associate section
## ==========================================
resource "aws_route_table_association" "pa1" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.pr.id
}
    



## ==================================
## Creating AWS public Subnet section
## ==================================

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr
}
## ========================================
## Creating AWS Private Subnet for fargate
## ========================================
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = var.private_subnet_cidr_tag
}
}
