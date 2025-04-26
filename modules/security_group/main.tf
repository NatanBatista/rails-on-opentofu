resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.security_group_name => sg }

  name        = each.value.security_group_name
  description = "Security group for my application"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow specific traffic"
    from_port   = each.value.ingress_from_port
    to_port     = each.value.ingress_to_port
    protocol    = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = each.value.egress_from_port
    to_port     = each.value.egress_to_port
    protocol    = each.value.egress_protocol
    cidr_blocks = each.value.egress_cidr_blocks
  }

  tags = merge(
    each.value.tags,
    {
      Name = each.value.security_group_name
    }
  )
}