variable "region" {
    description = "The AWS region to deploy the resources in."
    type        = string
    default     = "us-east-1"
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC."
    type        = string
    default = "10.0.0.0/24"
}

variable "vpc_name" {
    description = "The name of the VPC."
    type        = string
    default     = "rails-vpc"
}

variable "subnet_cidrs_public" {
    description = "A list of CIDR blocks for the subnets."
    type        = list(string)
    default     = ["10.0.0.0/28", "10.0.0.16/28"]
}

variable "subnet_cidrs_private" {
    description = "A list of CIDR blocks for the private subnets."
    type        = list(string)
    default     = ["10.0.0.128/28", "10.0.0.144/28"]
}

variable "availability_zones" {
    description = "A list of availability zones to use."
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b"]
}