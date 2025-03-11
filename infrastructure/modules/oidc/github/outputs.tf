output "github_oidc_arn" {
  description = "Github OIDC arn."
  value       = aws_iam_openid_connect_provider.github_oidc.arn
}