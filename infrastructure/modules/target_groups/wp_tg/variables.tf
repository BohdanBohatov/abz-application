variable "env" {
  description = "The infrastructure environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC id."
  type        = string
}

variable "health_interval" {
  description = "Interval for health check."
  type        = number
}

variable "health_timeout" {
  description = "Health check timeout."
  type        = number
}

variable "healthy_threshold" {
  description = "When consider system to be healthy."
  type        = number
}

variable "unhealthy_threshold" {
  description = "When consider system to be unhealthy."
  type        = number
}

variable "expected_healthy_server_response" {
  description = "Server HTTP response to consider it to be healthy (\"200\", \"201\" etc.)."
  type        = string
}

variable "instance_id" {
  description = "Instance ID."
  type        = string
}

variable "target_group_port" {
  description = "Target group port."
  type        = string
}

variable "instance_port" {
  description = "Instance port."
  type        = string
}