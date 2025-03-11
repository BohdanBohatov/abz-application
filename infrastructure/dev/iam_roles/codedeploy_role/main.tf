module "codedeploy_role" {
  source = "../../../modules/iam_roles/codedeploy_role"

  env = "dev"
}