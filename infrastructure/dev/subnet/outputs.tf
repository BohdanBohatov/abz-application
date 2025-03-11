output "public_subnet_1_id" {
  description = "1st public subnet id."
  value       = module.vpc_subnet.public_subnet_1_id
}

output "public_subnet_2_id" {
  description = "2nd public subnet id."
  value       = module.vpc_subnet.public_subnet_2_id
}

output "private_subnet_1_id" {
  description = "1st private subnet id."
  value       = module.vpc_subnet.private_subnet_1_id
}

output "private_subnet_2_id" {
  description = "2st private subnet id."
  value       = module.vpc_subnet.private_subnet_2_id
}

output "private_nat_subnet_1_id" {
  description = "1st private subnet id."
  value       = module.vpc_subnet.private_nat_subnet_1_id
}

output "private_nat_subnet_2_id" {
  description = "2st private subnet id."
  value       = module.vpc_subnet.private_nat_subnet_2_id
}