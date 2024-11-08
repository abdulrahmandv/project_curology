resource "aws_instance" "ec2" {
  ami                         = var.settings.ami
  instance_type               = var.settings.instance_type
  associate_public_ip_address = var.settings.associate_public_ip_address
  key_name                    = var.settings.key_name
  subnet_id                   = var.settings.subnet_id
  vpc_security_group_ids      = var.settings.security_group_ids
  user_data                   = var.settings.user_data #data.template_file.userdata.rendered
  availability_zone           = var.settings.availability_zone
  #security_groups             = var.settings.security_group 
  root_block_device {
    delete_on_termination = true
    volume_size           = var.settings.root_block_volume_size
  }

  dynamic "ebs_block_device" {
    for_each = var.settings.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
    }
  }
  #tags = lookup(var.settings.tags[name], var.hostname, null)
  tags = var.settings.tags
}