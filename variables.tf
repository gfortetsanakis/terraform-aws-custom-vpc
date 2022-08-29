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
}