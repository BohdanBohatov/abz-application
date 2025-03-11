output "mysql_endpoint" {
  description = "MySql instance endpoint."
  value       = aws_db_instance.mysql.endpoint
}

output "mysql_id" {
  description = "MySql instance ID"
  value       = aws_db_instance.mysql.id
}

output "mysql_subnet_group_id" {
  description = "MySql subnet group ID."
  value       = aws_db_subnet_group.mysql_subnet_group.id
}

output "mysql_subnet_group_name" {
  description = "MySql subnet group name."
  value       = aws_db_subnet_group.mysql_subnet_group.name
}

output "mysql_secret_arm" {
  description = "MySql subnet group name."
  value       = aws_db_instance.mysql.master_user_secret[0].secret_arn
}
