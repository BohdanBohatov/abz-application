module "wordpress_admin" {
  source = "../../../modules/secrets_manager/wordpress_admin"
  env    = "dev"
}
