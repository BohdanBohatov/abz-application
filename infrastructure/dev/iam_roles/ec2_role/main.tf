module "ec2_role" {
  source = "../../../modules/iam_roles/ec2_role"

  env                  = "dev"
  mysql_secret_arn     = data.terraform_remote_state.mysql.outputs.secret_arn
  wordpress_secret_arn = data.terraform_remote_state.wordpress_admin_credentials.outputs.wordpress_secret_arn
}