variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of allocated storage (in gigabytes)"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type to be associated with the RDS instance"
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "The database engine to use (e.g., mysql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class to use (e.g., db.t2.micro)"
  type        = string
}

variable "username" {
  description = "Username for the database"
  type        = string
}

variable "password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate with this instance"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Boolean indicating if the instance is publicly accessible"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before deletion"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to assign to the instance"
  type        = list(string)
  default     = []
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the instance"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  type = list(any)
}