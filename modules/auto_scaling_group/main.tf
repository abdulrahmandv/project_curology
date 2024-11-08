# Auto Scaling Group
resource "aws_autoscaling_group" "this" {
  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  vpc_zone_identifier       = var.subnet_ids
  desired_capacity          = var.desired_capacity
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  target_group_arns         = var.target_group_arns
  termination_policies      = var.termination_policies
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  force_delete              = var.force_delete
  protect_from_scale_in     = var.protect_from_scale_in

  tag {
    key                 = "Name"
    value               = var.instance_name_tag
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
