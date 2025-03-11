output "secret_arn" {
  description = "Secret with credentials."
  value       = module.mysql_rds.mysql_secret_arm
}