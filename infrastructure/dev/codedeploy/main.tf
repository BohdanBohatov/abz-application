module "wordpress_codedeploy" {
  source = "../../modules/codedeploy"

  env                 = "dev"
  codedeploy_iam_role = data.terraform_remote_state.codedeploy_role.outputs.codedeploy_role_arn
}