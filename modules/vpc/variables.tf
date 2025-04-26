variable "vpc_cidr" {
    description = "The CIDR block for the VPC."
    type        = string
}

variable "vpc_name" {
    description = "The name of the VPC."
    type        = string
}

variable "subnet_cidrs_public" {
    description = "A list of CIDR blocks for the subnets."
    type        = list(string)
}

variable "subnet_cidrs_private" {
    description = "A list of CIDR blocks for the private subnets."
    type        = list(string)
}

variable "availability_zones" {
    description = "A list of availability zones to use."
    type        = list(string)
}