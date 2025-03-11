module "elasticache_redis" {
  source = "../../../modules/databases/elasticache_redis"

  env                  = "dev"
  redis_version        = "6.0"
  parameter_group_name = "default.redis6.x"
  private_subnets      = [data.terraform_remote_state.subnets.outputs.private_subnet_1_id, data.terraform_remote_state.subnets.outputs.private_subnet_2_id]
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  security_group_ids   = [data.terraform_remote_state.redis_security_group.outputs.redis_security_group_id]
}