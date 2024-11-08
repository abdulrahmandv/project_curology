# Target Group Basic Configuration
variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port on which the target group is listening"
  type        = number
}

variable "target_group_protocol" {
  description = "The protocol to use for the target group (HTTP, HTTPS, TCP, etc.)"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID in which the target group will be created"
  type        = string
}

variable "target_type" {
  description = "The type of target to register with the target group (instance, ip, lambda)"
  type        = string
  default     = "instance"
}

# Health Check Configuration
variable "health_check_protocol" {
  description = "The protocol to use for health checks"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "The destination path for the health check request"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "The port to use for health checks"
  type        = string
  default     = "traffic-port"
}

variable "health_check_interval" {
  description = "The approximate interval, in seconds, between health checks of an individual target"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  type        = number
  default     = 3
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target"
  type        = string
  default     = "200"
}

# Stickiness Configuration
variable "stickiness_enabled" {
  description = "Whether to enable stickiness for the target group"
  type        = bool
  default     = false
}

variable "stickiness_type" {
  description = "The type of stickiness (only 'lb_cookie' is supported for Application Load Balancers)"
  type        = string
  default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target"
  type        = number
  default     = 86400
}

# Additional Tags
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
