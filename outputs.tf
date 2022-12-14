output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.vpc_public_subnet.*.id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "private_subnet_ids" {
  value = length(var.private_subnets) > 0 ? aws_subnet.vpc_private_subnet.*.id : []
}

output "private_route_table_id" {
  value = length(var.private_subnets) > 0 ? aws_default_route_table.private_rt[0].id : ""
}