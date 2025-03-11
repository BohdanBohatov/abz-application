output "redis_security_group_id" {
  description = "Redis security group."
  value       = module.redis_security_group.redis_security_group_id
}