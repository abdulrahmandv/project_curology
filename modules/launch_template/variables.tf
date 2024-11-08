variable "name_prefix" {
  description = "Prefix for the launch template name"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The SSH key name to use for the EC2 instances"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instances"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the EC2 instances"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instances"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "The subnet ID to launch the instances in"
  type        = string
}

variable "user_data" {
  description = "User data to provide when launching the instance"
  type        = string
  default     = ""
}

variable "disable_api_termination" {
  description = "If true, prevents instances from being terminated via the API"
  type        = bool
  default     = false
}

variable "shutdown_behavior" {
  description = "Shutdown behavior for the instances (stop or terminate)"
  type        = string
  default     = "stop"
}

variable "root_volume_device_name" {
  description = "The device name for the root volume"
  type        = string
  default     = "/dev/xvda"
}

variable "root_volume_size" {
  description = "The size of the root volume in GB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "The type of the root volume (gp2, io1, etc.)"
  type        = string
  default     = "gp2"
}

variable "instance_tags" {
  description = "Tags to apply to the instances launched from this template"
  type        = map(string)
  default     = {}
}
