output "security_group_id" {
  description = "EC2 security group ID."
  value       = module.ec2_security_group.ec2_security_group_id
}