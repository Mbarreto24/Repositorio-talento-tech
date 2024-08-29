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
resource "aws_security_group" "sg_ssh" {
  name        = "SG Acceso SSH"
  description = "Permite el acceso SSH desde cualquier lugar"
  vpc_id      = aws_vpc.VPC_proyecto.id

  tags = {
    Name = "SG_acceso_SSH_proyecto"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/00"]
    description = "Permite acceso al puerto 22"

  }

 ingress {
    from_port = 2357
    to_port = 2357
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/00"]
    description = "Permite acceso al puerto 22"

  }

ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/00"]
    description = "Permite acceso al puerto 22"

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    description = "Permite salida a cualquier ip y puerto "
  }  
}



resource "aws_route_table_association" "a_rt_default_proyecto" {
   subnet_id = aws_subnet.Subnet_public.id
   route_table_id = aws_route_table.rt_default_proyecto.id
}
