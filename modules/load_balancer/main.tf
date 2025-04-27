resource "aws_lb_target_group" "this" {
  name        = "${var.balancer_name}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/up"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = var.tags
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn  # Referenciando o Target Group
  }
}

## Cria o load balancer
resource "aws_lb" "this" {
  name               = var.balancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
  enable_cross_zone_load_balancing = true
  

  tags = var.tags
}