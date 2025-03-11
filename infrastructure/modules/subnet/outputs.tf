output "public_subnet_1_id" {
  description = "1st public subnet id."
  value       = aws_subnet.public_zone_1.id
}

output "public_subnet_2_id" {
  description = "2nd public subnet id."
  value       = aws_subnet.public_zone_2.id
}

output "private_subnet_1_id" {
  description = "1st private subnet id."
  value       = aws_subnet.private_zone_1.id
}

output "private_subnet_2_id" {
  description = "2st private subnet id."
  value       = aws_subnet.private_zone_2.id
}

output "private_nat_subnet_1_id" {
  description = "1st private subnet id with NAT."
  value       = aws_subnet.private_nat_zone_1.id
}

output "private_nat_subnet_2_id" {
  description = "2st private subnet id with NAT."
  value       = aws_subnet.private_nat_zone_2.id
}