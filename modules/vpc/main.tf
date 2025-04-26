# Criação da VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Subsnets públicas
resource "aws_subnet" "public" {
  count = length(var.subnet_cidrs_public)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.subnet_cidrs_public, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

# Subsnets privadas
resource "aws_subnet" "private" {
  count = length(var.subnet_cidrs_private)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.subnet_cidrs_private, count.index)
  availability_zone = element(var.availability_zones, count.index)
  
  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}

# Elastic IP
resource "aws_eip" "this" {
  tags = {
    Name = "${var.vpc_name}-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-natgw"
  }
}

# Tabela de rotas pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Associação da tabela pública às subnets públicas
resource "aws_route_table_association" "public" {
  count = length(var.subnet_cidrs_public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Tabela de rotas privadas
resource "aws_route_table" "private" {
  count = length(var.subnet_cidrs_private)
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "${var.vpc_name}-private${count.index + 1}-rt"
  }
}

# Associação das tabelas de rotas privadas às subnets privadas
resource "aws_route_table_association" "private" {
  count = length(var.subnet_cidrs_private)
  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private[count.index].id
}
