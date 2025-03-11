output "redis_cluster_id" {
  description = "Elasticache Redis "
  value       = aws_elasticache_cluster.elasticache_redis.id
}

output "redis_primary_endpoint" {
  description = "Elasticache Redis "
  value       = aws_elasticache_cluster.elasticache_redis.cache_nodes.0.address
}