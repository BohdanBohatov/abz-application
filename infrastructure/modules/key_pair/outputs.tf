output "key_name" {
  description = "Key name"
  value       = aws_key_pair.ec2_ssh_key.key_name
}