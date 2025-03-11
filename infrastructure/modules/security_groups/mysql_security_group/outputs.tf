output "mysql_security_group_id" {
  description = "MySql security group ID."
  value       = aws_security_group.mysql_sg.id
}