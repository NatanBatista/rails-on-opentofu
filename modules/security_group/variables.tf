variable "vpc_id" {
  description = "ID do VPC"
  type        = string
  
}

variable "security_groups" {
  description = "Lista de Security Groups"
  type = list(object({
    security_group_name = string
    ingress_from_port   = number
    ingress_to_port     = number
    protocol            = string
    cidr_blocks         = list(string)
    egress_from_port    = number
    egress_to_port      = number
    egress_protocol     = string
    egress_cidr_blocks  = list(string)
    tags                = map(string)
  }))
}
