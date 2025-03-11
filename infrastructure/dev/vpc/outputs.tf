output "vpc_id" {
  description = "VPC id."
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "VPC arn."
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "VPC cidr block."
  value       = module.vpc.vpc_cidr_block
}