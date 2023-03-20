# resource "aws_vpc" "demo_vpc" {
#     cidr_block = "10.0.0.0/18"

#     tags = {
#         Name = "Demo VPC"
#     }          
# }

# resource "aws_subnet" "public_subnet" {
#     vpc_id = aws_vpc.demo_vpc.id
#     cidr_block = "10.0.0.0/24"

#     tags = {
#       Name = "Public Subnet"
#     }
# }

# resource "aws_subnet" "private_subnet" {
#     vpc_id = aws_vpc.demo_vpc.id
#     cidr_block = "10.0.1.0/24"

#     tags = {
#       Name = "Private Subnet"
#     }
# }
