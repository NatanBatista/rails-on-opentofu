variable "region" {
  description = "The AWS region to deploy the resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/24"
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

variable "sg_name" {
  description = "The name of the security group."
  type        = string
  default     = "rails-lb-sg"

}

variable "balancer_name" {
  description = "Name of Load balancer"
  type        = string
  default     = "rails-lb"
}

variable "internal" {
  description = "If load balancer is internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  type        = string
  default     = "application"
}

variable "tags" {
  description = "Tags for load balancer"
  type        = map(string)
  default     = {}
}

variable "enable_deletion_protection" {
  description = "Habilita proteção contra exclusão"
  type        = bool
  default     = false
}

variable "rails_master_key" {
  description = "Rails master key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "container_image" {
  description = "Imagem do container"
  type        = string
  default     = "rails:latest"
}

