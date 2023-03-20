region = "us-east-1"
# private_subnet_id = aws_subnet.private_subnet.id
# public_subnet_id = aws_subnet.public_subnet.id
# vpc_id = aws_vpc.demo_vpc.id
ec2_ami = "ami-0557a15b87f6559cf"
ec2_instance_type = "t2.micro"
vpc_cidr_block = "10.0.0.0/18" 
public_subnet_cidr_block = "10.0.0.0/24"
private_subnet_cidr_block = "10.0.1.0/24"
security_group_description = "Allow TLS inbound traffic"
project = "iac-terraform-demo1"
tags = {
  "Environment"     = "UAT"
  "Terraform"       = "true"
  "sharedResource"  = "Yes"
  "Owner"           = "DE Tribe"
  "ManagedBy"       = "DevSecOps"
  "BusinessOwner"   = ""
  "Project"         = "IaC-terraform-demo1"
  "CreatedBy"       = "Martin Mwangi"
  "OrgBackupPolicy" = "None"
  "CRQ"             = ""
}

# security_group_tags = {
#     Name = "Demo security group"
#   }
# vpc_tags = {
#         Name = "Demo VPC 2"
#     }
# public_subnet_tags = {
#       Name = "Public Subnet"
#     }

# private_subnet_tags = {
#       Name = "Private Subnet"
#     }

# internet_gateway_tags = {
#     Name = "Internet Gateway"
#   }

# nat_gateway_eip_tags = {
#       Name = "NAT Gateway Elastic IP"
#     }

# nat_gateway_tags = {
#     Name = "Main NAT Gateway"
#   }

# public_route_table_tags = {
#     Name = "Public Route Table"
#   }

# private_route_table_tags = {
#     Name = "Private Route Table"
#   }
# ec2_instance_tags = {
#     Name = "Demo EC2 Instance"
#   }

key_pair_name = "terraform-aws-keypair"