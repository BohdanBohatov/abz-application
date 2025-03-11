output "wordpress_tg_arn" {
  description = "Wordpress target group arn"
  value       = module.wordpress_target_group.wordpress_target_group_arn
}
