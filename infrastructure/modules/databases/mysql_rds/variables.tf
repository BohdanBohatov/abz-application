variable "env" {
  description = "Environment."
  type        = string
}

variable "db_identifier" {
  description = "Database RDS instance identifier."
  type        = string
}

variable "engine_version" {
  description = "Mysql db version."
  type        = string
}

variable "instance_type" {
  description = "Instance where to deploy mysql."
  type        = string
}

variable "allocated_storage" {
  description = "Storage capacity."
  type        = number
}

variable "db_name" {
  description = "Database name."
  type        = string
}

variable "db_username" {
  description = "Database user name."
  type        = string
}

variable "storage_type" {
  description = "Storage type."
  type        = string
}

variable "security_group_id" {
  description = "Mysql security group id."
  type        = string
}

variable "skip_final_snapshot" {
  description = "Does MySql need final snapshot."
  type        = bool
}

variable "private_subnet_ids" {
  description = "Private subnets ids."
  type        = list(string)
}