output "wp_alb_security_group_id" {
  description = "Wordpress application load balancer security group ID."
  value       = module.wp_alb_security_group.wp_alb_security_group_id
}