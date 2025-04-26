# VPC ID
output "vpc_id" {
  description = "The ID of the Rails VPC"
  value = aws_vpc.this.id
}

# Subnets públicas IDs
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value = aws_subnet.public[*].id
}

# Subnets privadas IDs
output "private_subnets_ids" {
  description = "The IDS of the private subnets"
  value = aws_subnet.private[*].id
}

# Internet Gateway ID
output "Internet_gateway_id" {
  description = "The ID of the internet gateway"
  value = aws_internet_gateway.this.id
}

# NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

# Route Table Pública ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

# Route Tables Privadas IDs
output "private_route_table_ids" {
  description = "The IDs of the private route tables"
  value       = aws_route_table.private[*].id
}