# Target Group
resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    protocol            = var.health_check_protocol
    path                = var.health_check_path
    port                = var.health_check_port
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.health_check_matcher
  }

  stickiness {
    type            = var.stickiness_type
    enabled         = var.stickiness_enabled
    cookie_duration = var.stickiness_cookie_duration
  }

  # Tags for the Target Group
  tags = var.tags
}
