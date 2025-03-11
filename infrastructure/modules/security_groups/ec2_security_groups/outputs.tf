output "ec2_security_group_id" {
  description = "EC2 security group"
  value       = aws_security_group.allow_ssh_ec2_sg.id
}