output "elasticache_redis_cluster_id" {
  description = "Elastic cache."
  value       = module.elasticache_redis.redis_cluster_id
}

output "elasticache_redis_primary_endpoint" {
  description = "Elastic cache."
  value       = module.elasticache_redis.redis_primary_endpoint
}
