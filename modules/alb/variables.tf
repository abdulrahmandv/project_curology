# ALB Configuration
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to assign to the ALB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch the ALB in"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection should be enabled for the ALB"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The idle timeout in seconds for the ALB"
  type        = number
  default     = 60
}

# Target Group ARN (from ASG module)
variable "target_group_arn" {
  description = "ARN of the target group to associate with the ALB"
  type        = string
}