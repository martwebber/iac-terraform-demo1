
# data "aws_region" "current" {}

# resource "aws_vpc_ipam" "test" {
#   operating_regions {
#     region_name = data.aws_region.current.name
#   }
# }

# resource "aws_vpc_ipam_pool" "test" {
#   address_family = "ipv4"
#   ipam_scope_id  = aws_vpc_ipam.test.private_default_scope_id
#   locale         = data.aws_region.current.name
# }

# resource "aws_vpc_ipam_pool_cidr" "test" {
#   ipam_pool_id = aws_vpc_ipam_pool.test.id
#   cidr         = "172.2.0.0/16"
# }

# resource "aws_vpc" "test" {
#   ipv4_ipam_pool_id   = aws_vpc_ipam_pool.test.id
#   ipv4_netmask_length = 28
#   depends_on = [
#     aws_vpc_ipam_pool_cidr.test
#   ]
# }

resource "aws_vpc" "demo_vpc" {
    cidr_block = "10.0.0.0/18"

    tags = {
        Name = "Demo VPC"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.0.0/24"

    tags = {
      Name = "Public Subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "Private Subnet"
    }
}

# Internet gateway is used by the private subnet

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

# Elastic IP for NAT gateway
resource "aws_eip" "nat_gateway_ip" {
    vpc = true
    depends_on = [aws_internet_gateway.internet_gateway]
    tags = {
      Name = "NAT Gateway Elastic IP"
    }
}

# NAT gateway for VPC
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_ip.id
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "Main NAT Gateway"
  }
}

# Routing table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "Public Route Table"
  }
  
}
# Associate public subnet and publit route table
resource "aws_route_table_association" "public_subnet_route_table" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
  
}

# Routing table for private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "Private Route Table"
  }
  
}
# Associate public subnet and publit route table
resource "aws_route_table_association" "private_subnet_route_table" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
  
}

# Create a security group for ec2

resource "aws_security_group" "demo_security_group" {
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo_vpc.id

 # To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  # To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  
# Allow TLS
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.demo_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Demo security group"
  }
}

resource "aws_instance" "demo_ec2_instance" {
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  #security_groups = [aws_security_group.demo_security_group.name]
  subnet_id = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.demo_security_group.id]
  key_name = "terraform-aws-keypair"
  tags = {
    Name = "Demo EC2 Instance"
  }
}