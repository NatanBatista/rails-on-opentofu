module "vpc" {
    source = "./modules/vpc"

    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    subnet_cidrs_public = var.subnet_cidrs_public
    subnet_cidrs_private = var.subnet_cidrs_private
    availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id

  security_groups = [
    {
      security_group_name = "rails-lb-sg"
      ingress_from_port   = 80
      ingress_to_port     = 80
      protocol            = "tcp"
      cidr_blocks         = ["0.0.0.0/0"]
      egress_from_port    = 0
      egress_to_port      = 0
      egress_protocol     = "-1"
      egress_cidr_blocks  = ["0.0.0.0/0"]
      tags                = {
        Environment = "production"
      }
    },
  ]
}

module "load_balancer" {
    source              = "./modules/load_balancer"
    balancer_name       = var.balancer_name
    internal            = var.internal
    security_groups     = [module.security_groups.security_group_ids[0]]
    subnets             = module.vpc.public_subnet_ids
    load_balancer_type  = "application"
    enable_deletion_protection = false
    tags                = {
        Environment = "production"
    }
}
