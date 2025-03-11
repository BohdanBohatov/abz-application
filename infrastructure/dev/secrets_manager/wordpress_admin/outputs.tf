output "wordpress_secret_arn" {
  description = "Wordpress credentials arn."
  value       = module.wordpress_admin.wordpress_secret_arn
}