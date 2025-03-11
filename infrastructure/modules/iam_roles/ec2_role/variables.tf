variable "env" {
  description = "Environment."
}

variable "mysql_secret_arn" {
  description = "Secret ARN to be able to get mysql credentials"
}

variable "wordpress_secret_arn" {
  description = "EC2 profile role."
}