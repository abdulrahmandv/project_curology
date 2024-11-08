output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

output "launch_template_name" {
  description = "The name of the launch template"
  value       = aws_launch_template.this.name
}
