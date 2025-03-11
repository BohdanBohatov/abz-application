resource "random_password" "admin_password" {
  length           = 10
  special          = true
  upper            = true
  numeric          = true
  override_special = "!#$.,|%&*()-_=+[]{}<>:?"
}


resource "aws_secretsmanager_secret" "wordpress_secret_manager" {
  name = "${var.env}-env/wordpress-prj"

  tags = {
    "Environment" = "${var.env}"
    "ManagedBy"   = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "wordpress_admin_credentials" {
  secret_id = aws_secretsmanager_secret.wordpress_secret_manager.id
  secret_string = jsonencode({
    admin_name     = "wodrpress-admin"
    admin_password = random_password.admin_password.result
    }
  )
}
