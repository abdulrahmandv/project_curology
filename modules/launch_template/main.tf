# Main configuration for the EC2 Launch Template

resource "aws_launch_template" "this" {
  name_prefix                          = var.name_prefix
  image_id                             = var.ami_id
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.shutdown_behavior
  vpc_security_group_ids               = var.security_group_ids
  user_data                            = var.user_data != "" ? base64encode(var.user_data) : null
  #   iam_instance_profile {
  #     name = var.iam_instance_profile
  #   }

  # Network interfaces
  #   network_interfaces {
  #     associate_public_ip_address = var.associate_public_ip_address
  #     subnet_id                   = var.subnet_id
  #     security_groups             = var.security_group_ids
  #   }

  # Block device mappings
  block_device_mappings {
    device_name = var.root_volume_device_name
    ebs {
      volume_size           = var.root_volume_size
      volume_type           = var.root_volume_type
      delete_on_termination = true
    }
  }

  # Tagging the instances created from this template
  tag_specifications {
    resource_type = "instance"
    tags          = var.instance_tags
  }
}
