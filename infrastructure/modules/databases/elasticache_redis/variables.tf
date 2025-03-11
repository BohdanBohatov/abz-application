variable "env" {
  description = "Environment."
  type        = string
}

variable "redis_version" {
  description = "value"
  type        = string
}

variable "parameter_group_name" {
  description = "value"
  type        = string
}

variable "private_subnets" {
  description = "Subnets for subnet group."
  type        = set(string)
}

variable "node_type" {
  description = "value"
  type        = string
}

variable "num_cache_nodes" {
  description = "value"
  type        = number
}

variable "security_group_ids" {
  description = "Security groups."
  type        = set(string)
}

