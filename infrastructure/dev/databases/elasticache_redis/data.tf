data "terraform_remote_state" "redis_security_group" {
  backend = "local"
  config = {
    path = "../../security_groups/elasticache_redis_security_group/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnets" {
  backend = "local"
  config = {
    path = "../../subnet/terraform.tfstate"
  }
}