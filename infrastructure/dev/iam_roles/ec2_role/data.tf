data "terraform_remote_state" "mysql" {
  backend = "local"
  config = {
    path = "../../databases/mysql_rds/terraform.tfstate"
  }
}

data "terraform_remote_state" "wordpress_admin_credentials" {
  backend = "local"
  config = {
    path = "../../secrets_manager/wordpress_admin/terraform.tfstate"
  }
}