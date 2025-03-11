output "mysql_security_group_id" {
  description = "MySql security group."
  value       = module.mysql_security_group.mysql_security_group_id
}