
#vpc
resource "aws_vpc" "nti_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "nti-vpc"
  }
}

#pub-subnets
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.nti_vpc.id
  cidr_block = var.pub_sub_cidr  
  availability_zone= var.availability_zone   
  
  tags = {
    Name = "pub-subnet"
  }
}




# Create a internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nti_vpc.id

  tags = {
    Name = "nti-igw"
  }
}



#route table public
resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.nti_vpc.id
  route {
    cidr_block = var.cidr_all
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route-public-table "
  }
}



resource "aws_route_table_association" "route-table-association-subnet-igw" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.pub-route-table.id
}




resource "aws_security_group" "sg" {
  name        = "security-group"
  description = "Security group allowing http traffic"
  vpc_id      = aws_vpc.nti_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all] // Allows SSH from any IPv4 address
  }
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = [var.cidr_all] // Allows HTTP from any IPv4 address
#   }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all]
  }
  tags = {
    Name = "nti-sg"
  }
}