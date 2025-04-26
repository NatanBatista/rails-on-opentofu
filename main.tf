module "vpc" {
    source = "./modules/vpc"

    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    subnet_cidrs_public = var.subnet_cidrs_public
    subnet_cidrs_private = var.subnet_cidrs_private
    availability_zones = var.availability_zones
}