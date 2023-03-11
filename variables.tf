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

variable "ec2_ami" {
  description = "EC2 AMI"
  type = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type = string
  
}
