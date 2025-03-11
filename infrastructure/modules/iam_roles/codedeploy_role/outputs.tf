output "codedeploy_role_arn" {
  description = "Role arn."
  value       = aws_iam_role.codedeploy_iam_role.arn
}

output "codedeploy_role_name" {
  description = "Role name."
  value       = aws_iam_role.codedeploy_iam_role.name
}