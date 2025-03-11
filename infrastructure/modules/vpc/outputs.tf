output "vpc_arn" {
  description = "VPC arn."
  value       = aws_vpc.main.arn
}

output "vpc_id" {
  description = "VPC id."
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "VPC cidr block."
  value       = aws_vpc.main.cidr_block
}