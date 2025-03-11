output "github_for_codedeploy_role_arn" {
  description = "Github for codedeploy role arn."
  value       = aws_iam_role.github_for_codedeploy_role.arn
}

output "github_for_codedeploy_name" {
  description = "Github for codedeploy role name."
  value       = aws_iam_role.github_for_codedeploy_role.name
}