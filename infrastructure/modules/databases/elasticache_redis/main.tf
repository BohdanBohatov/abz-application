resource "aws_elasticache_subnet_group" "elasticache_redis_subnet_group" {
  name       = "${var.env}-redis-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_elasticache_cluster" "elasticache_redis" {
  cluster_id           = "${var.env}-redis-cluster"
  engine               = "redis"
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_redis_subnet_group.name
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.redis_version
  port                 = 6379
  security_group_ids   = var.security_group_ids

  tags = {
    "Name" = "${var.env}-redis-db"
  }
}