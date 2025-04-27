variable "balancer_name" {
  description = "Name of Load balancer"
  type = string
}

variable "internal" {
  description = "If load balancer is internal"
  type = bool
  default = false
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  type = string
}

variable "security_groups" {
  description = "List of associated security groups on the load balancer"
  type = list(string)
}

variable "subnets" {
  description = "List of groups where the load balancer will be created"
  type = list(string)
}

variable "tags" {
  description = "Tags for load balancer"
  type = map(string)
  default = {}
}

variable "enable_deletion_protection" {
  description = "Habilita proteção contra exclusão"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID do VPC"
  type        = string
  
}