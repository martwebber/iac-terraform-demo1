provider "aws" {
  region = "us-east-1"
}

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

resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.0.0.0/18"

    tags = {
        Name = "Demo VPC"
    }
}

resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = "10.0.0.0/24"

    tags = {
      Name = "Public Subnet"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "Private Subnet"
    }
}

resource "aws_internet_gateway" "Internet-gateway" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

# Elastic IP for NAT gateway
resource "aws_eip" "nat-gateway-ip" {
    vpc = true
}