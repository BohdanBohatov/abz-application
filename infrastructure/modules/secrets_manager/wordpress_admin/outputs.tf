output "wordpress_secret_arn" {
  description = "Wordpress secret arn, that has admin credentials."
  value       = aws_secretsmanager_secret.wordpress_secret_manager.arn
}