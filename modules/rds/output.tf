output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.this.id
}

output "db_instance_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_arn" {
  description = "The RDS instance ARN"
  value       = aws_db_instance.this.arn
}
output "db_password" {
  value = aws_db_instance.this.password
}

output "db_username" {
  value = aws_db_instance.this.username
}