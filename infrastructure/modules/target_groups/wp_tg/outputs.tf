output "wordpress_target_group_arn" {
  description = "Target group arn"
  value       = aws_lb_target_group.wp_target_group.arn
}
