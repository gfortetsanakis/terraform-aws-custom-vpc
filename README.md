# AWS custom VPC module

This module creates a custom VPC in AWS consisting of configurable public and private subnets. Public subnets communicate to the Internet via an Internet gateway and appropriate routing tables are configured for routing traffic within the VPC both for the public and private subnets.

To reduce the costs of communication with the AWS S3 service from private subnets, a VPC gateway endpoint is also created and the routing table of private subnets is updated to farward S3 traffic to this gateway.

The input parameters of the module are described in detail in the following table:

| Parameter               | Type     | Description                                                                                 |
| ----------------------- | -------- | ------------------------------------------------------------------------------------------- |
| vpc_cidr                | Required | The cidr block of the VPC                                                                   |
| aws_region              | Required | The AWS region at which the VPC will be deployed                                            |
| public_subnets          | Required | A list with the cidrs of the public subnets                                                 |
| private_subnets         | Optional | A list with the cidrs of the private subnets                                                |
| create_s3_gateway       | Optional | Boolean variable indicating whether a VPC gateway endpoint will be created for accessing S3 |
| map_public_ip_on_launch | Optional | Boolean variable indicating whether a public IP is automatically assinged to EC2 instances created in public subnets |


The output parameters are the following:

| Parameter              | Description                                                    |
| ---------------------- | -------------------------------------------------------------- |
| vpc_id                 | The id of the created VPC                                      |
| public_subnet_ids      | A list with the ids of the public subnets                      |
| private_subnet_ids     | A list with the ids of the private subnets                     |
| public_route_table_id  | The id of the route table associated with the public subnets   |
| private_route_table_id | THe id of the route table associated with the private subnets  |
