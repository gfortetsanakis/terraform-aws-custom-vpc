variable "vpc_cidr" {
  description = "The cidr block of the VPC."    
}
variable "aws_region" {
  description = "The AWS region at which the VPC will be deployed."    
}
variable "public_subnets" {
  description = "A list with the cidrs of the public subnets."    
}
variable "private_subnets" {
  description = "A list with the cidrs of the private subnets."
  default = []    
}

variable "create_s3_gateway" {
  description = "Boolean variable indicating whether a VPC gateway endpoint will be created for accessing S3."
  default = true
}

variable "map_public_ip_on_launch" {
  description = "Boolean variable indicating whether a public IP is automatically assinged to EC2 instances created in public subnets."
  default = true
}