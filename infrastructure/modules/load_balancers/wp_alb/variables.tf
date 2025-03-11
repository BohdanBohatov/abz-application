variable "env" {
  description = "The infrastructure environment"
  type        = string
}

variable "subnets_ids" {
  description = "Public subnets."
  type = set(string)
}

variable "security_group_ids" {
  description = "Security groups to attach to the ALB."
  type = set(string)
}

variable "target_group_arn" {
  description = "Target group to receive traffic."
  type = string
}

variable "route53_zone_id" {
  description = "Route53 zone ID."
  type = string
}

variable "certificate_arn" {
  description = "TLS/SSL sertificate arn."
  type = string
}