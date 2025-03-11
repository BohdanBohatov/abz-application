output "ec2_role_arn" {
  description = "Role arn."
  value       = aws_iam_role.ec2_role.arn
}

output "ec2_role_name" {
  description = "Role name."
  value       = aws_iam_role.ec2_role.name
}