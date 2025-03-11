output "redis_security_group_id" {
  description = "ElastiCache Redis security group ID."
  value       = aws_security_group.elasticache_sg.id
}