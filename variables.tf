variable "region"{
    description = "The region to deploy our resources"
    type = string
}

# variable "vpc_id" {
#   description = "VPC ID"
#   type = string
# }

# variable "private_subnet_id" {
#   description = "Private subnet ID"
#   type = string
# }

# variable "public_subnet_id" {
#   description = "Public subnet ID"
#   type = string
# }

variable "project" {
  description = "Project name"
  type= string
}

variable "ec2_ami" {
  description = "EC2 AMI"
  type = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type = string
  
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string
  default = "10.0.0.0/18"
  
}

variable "tags" {
  description = "Tags to be used on the project"
  type = map(any)
  default = {}
}

# variable "public_subnet_tags" {
#   description = "Public subnet tags"
#   type = map(any)
#   default = {}
# }

# variable "private_subnet_tags" {
#   description = "Private subnet tags"
#   type = map(any)
#   default = {}
# }

# variable "internet_gateway_tags" {
#   description = "Internet gateway tags"
#   type = map(any)
#   default = {}
# }

# variable "nat_gateway_eip_tags" {
#   description = "NAT gateway elastic IP"
#   type = map(any)
#   default = {}
# }

# variable "nat_gateway_tags" {
#   description = "NAT gateway tags"
#   type = map(any)
#   default = {}
# }

# variable "public_route_table_tags" {
#   description = "Public route table tags"
#   type = map(any)
#   default = {}  
# }

# variable "private_route_table_tags" {
#   description = "Private route table tags"
#   type = map(any)
#   default = {}
# }

# variable "security_group_tags" {
#   description = "Security group tags"
#   type = map(any)
#   default = {}
# }

# variable "ec2_instance_tags" {
#   description = "EC2 instance tags"
#   type = map(any)
#   default = {} 
  
# }

variable "security_group_description" {
  description = "Security group description"
  type = string
  default = ""
}


variable "default_cidr_block" {
  description = "Default CIDR block"
  type = string
  default = "0.0.0.0/0" 
}

variable "public_subnet_cidr_block" {
  description = "Public subnet CIDR block"
  type = string
  default = "172.31.0.0/16"
}

variable "private_subnet_cidr_block" {
  description = "Private subnet CIDR block"
  type = string
  default = "172.31.0.0/16"
}

variable "key_pair_name" {
  description = "Key pair name"
  type = string
  default = ""
}