output "wp_alb_security_group_id" {
  description = "Wordpress application load balancer security group"
  value       = aws_security_group.wordpress_application_lb.id
}