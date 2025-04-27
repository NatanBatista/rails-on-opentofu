data "aws_iam_role" "LabRole" {
  name = "LabRole"
}

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
      ingress_protocol    = "tcp"
      cidr_blocks         = ["0.0.0.0/0"]
      security_groups = []
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

# Create the service security group separately
module "service_security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

  security_groups = [
    {
      security_group_name = "rails-service-sg"
      ingress_from_port   = 0
      ingress_to_port     = 65535
      ingress_protocol    = "tcp"
      cidr_blocks         = []  # Empty list since we're using security_groups
      security_groups     = [module.security_groups.security_group_ids[0]]  # Now we can reference the existing SG
      egress_from_port    = 0
      egress_to_port      = 0
      egress_protocol     = "-1"
      egress_cidr_blocks  = ["0.0.0.0/0"]
      tags                = {
        Environment = "production"
      }
    }
  ]
}

module "load_balancer" {
    source              = "./modules/load_balancer"
    vpc_id              = module.vpc.vpc_id
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


module "ecs" {
  source              = "./modules/ecs"
  cluster_name        = "rails-tofu"
  repository_name     = "rails-on-tofu"
  task_family         = "rails-tofu-task"
  execution_role_arn  = data.aws_iam_role.LabRole.arn
  # task_role_arn       = aws_iam_role.ecs_execution_role.arn
  container_name      = "rails-tofu-container"
  container_image     = "171562142676.dkr.ecr.us-east-1.amazonaws.com/natanbatista/rails-on-terraform"
  cpu                 = "256"
  memory              = "512"
  service_name        = "rails-tofu-service"
  subnets             = module.vpc.private_subnets_ids
  security_groups     = [module.service_security_group.security_group_ids[0]]
  desired_count       = 2
  target_group_arn = module.load_balancer.target_group_arn
  tags                = {
    Environment = "production"
  }
}
