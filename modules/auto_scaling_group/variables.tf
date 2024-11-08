# Launch Template Variables
variable "launch_template_id" {
  description = "ID of the Launch Template to use for the Auto Scaling Group"
  type        = string
}

variable "launch_template_version" {
  description = "Version of the Launch Template to use (use $Latest or $Default for dynamic selection)"
  type        = string
  default     = "$Latest"
}

# Auto Scaling Group Configuration
variable "subnet_ids" {
  description = "List of subnet IDs to associate with the Auto Scaling Group"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum capacity for the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum capacity for the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "health_check_type" {
  description = "Type of health check (EC2 or ELB)"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) to wait for health check after instance launch"
  type        = number
  default     = 300
}

variable "target_group_arns" {
  description = "List of target group ARNs for the Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "A list of termination policies for the Auto Scaling Group"
  type        = list(string)
  default     = ["OldestInstance"]
}

variable "wait_for_capacity_timeout" {
  description = "Time to wait for the desired capacity before timing out"
  type        = string
  default     = "0"
}

variable "force_delete" {
  description = "Whether to forcefully delete the Auto Scaling Group"
  type        = bool
  default     = false
}

variable "protect_from_scale_in" {
  description = "Whether instances are protected from termination during scale-in"
  type        = bool
  default     = false
}

# Instance Tag
variable "instance_name_tag" {
  description = "Name tag for instances in the Auto Scaling Group"
  type        = string
}
