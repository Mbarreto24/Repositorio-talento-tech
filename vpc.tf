resource "aws_vpc" "VPC_proyecto" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC_proyecto"
  }
}
resource "aws_subnet" "Subnet_public" {
  vpc_id = aws_vpc.VPC_proyecto.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Subnet_ec2"
  }
}


resource "aws_internet_gateway" "Gw_proyecto" {
  vpc_id = aws_vpc.VPC_proyecto.id

  tags = {
    Name = "Gw_proyecto"
  }
}
resource "aws_route_table" "rt_default_proyecto" {
   vpc_id = aws_vpc.VPC_proyecto.id
   
   route  {
    cidr_block = "0.0.0.0/00"
    gateway_id = aws_internet_gateway.Gw_proyecto.id
}
    tags = {
        Name = "rt_default_proyecto"
    }
 }

resource "aws_route_table_association" "a_rt_default_proyecto" {
   subnet_id = aws_subnet.Subnet_public.id
   route_table_id = aws_route_table.rt_default_proyecto.id
}
