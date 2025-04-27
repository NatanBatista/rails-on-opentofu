resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.security_group_name => sg }

  name        = each.value.security_group_name
  description = "Security group for my application"
  vpc_id      = var.vpc_id

  # Regras inbound e outbound

  # Regras de entrada (ingress)
  ingress {
    description = "Allow specific traffic"
    from_port   = each.value.ingress_from_port
    to_port     = each.value.ingress_to_port
    protocol    = each.value.ingress_protocol


    # Verifica se há CIDR blocks ou security_groups e usa o apropriado
    cidr_blocks = length(each.value.cidr_blocks) > 0 ? each.value.cidr_blocks : null
    security_groups = length(each.value.security_groups) > 0 ? each.value.security_groups : null
  }

  # Regras de saída (egress)
  egress {
    description = "Allow all outbound traffic"
    from_port   = each.value.egress_from_port
    to_port     = each.value.egress_to_port
    protocol    = each.value.egress_protocol
    
    cidr_blocks = length(each.value.egress_cidr_blocks) > 0 ? each.value.egress_cidr_blocks : null
  }

  tags = merge(
    each.value.tags,
    {
      Name = each.value.security_group_name
    }
  )
}